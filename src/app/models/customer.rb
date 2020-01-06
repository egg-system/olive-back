class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable
  audited except: :tokens

  include DeviseTokenAuth::Concerns::User
  include PaginationModule

  belongs_to(
    :first_visit_store,
    optional: true,
    class_name: 'Store',
    foreign_key: 'first_visit_store_id'
  )

  belongs_to(
    :last_visit_store,
    optional: true,
    class_name: 'Store',
    foreign_key: 'last_visit_store_id'
  )

  belongs_to :job_type, optional: true
  belongs_to :zoomancy, optional: true
  belongs_to :baby_age, optional: true
  belongs_to :size, optional: true
  belongs_to :visit_reason, optional: true
  belongs_to :nearest_station, optional: true

  has_many :reservations

  before_validation :sync_none_uid

  validates :tel, numericality: { allow_blank: true }
  validates :password, presence: true, on: :create, if: :member?
  validates :email, uniqueness: true, unless: :common_email?

  #left join
  scope :join_size, ->{
    left_joins(:size).select("sizes.name as size_name")
  }

  scope :join_tables, ->{
    select('customers.*').join_size
  }

  scope :like_name, ->(name){
    where("concat(last_name, first_name) like ?", "%#{name}%") if name.present?
  }

  scope :like_tel, -> (tel) {
    where('tel LIKE ?', "%#{tel}%") if tel.present?
  }

  scope :like_email, -> (email) {
    where('email LIKE ?', "%#{email}%") if email.present?
  }

  attr_accessor :age, :display_email

  # 本メソッドは、メールアドレスの重複を前提としている
  # 電話番号などによるマージの場合、処理を修正する必要がある
  def self.merge(merge_from_id, merge_to_id)
    merge_from_customer = find(merge_from_id)
    merge_from_customer.reservations.update(customer_id: merge_to_id)

    merge_to_customer = find(merge_to_id)

    if !merge_to_customer.member? && merge_from_customer.member?
      merge_to_customer.uid = merge_from_customer.uid
      merge_to_customer.encrypted_password = merge_from_customer.encrypted_password
      merge_to_customer.provider = 'email'
    end

    merge_from_customer.destroy!
    merge_to_customer.save!

    return merge_from_customer
  end

  def age
    return nil if self.birthday.nil?
    return (Date.today.strftime('%Y%m%d').to_i - self.birthday.strftime('%Y%m%d').to_i) / 10000
  end

  def full_name
    return self.last_name + ' ' + self.first_name
  end

  def display_email
    return nil if self.new_record?
    return self.email.nil? ? self.common_email : self.email
  end

  def display_email=(email)
    self.email = email unless email === self.common_email
  end

  def common_email?
    return self.display_email === self.common_email
  end

  protected

  def member?
    return self.provider != 'none'
  end

  protected

  def is_none_provider?
    provider === 'none'
  end

  def sync_none_uid
    self.uid = Time.now.to_s unless is_none_provider?
  end

  def common_email
    return Settings.customer.common_email
  end
end
