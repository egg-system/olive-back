class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable
  audited except: :tokens

  include DeviseTokenAuth::Concerns::User
  include PaginationModule
  include SquareCustomerModule

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
  belongs_to :medical_record, optional: true

  has_many :reservations
  has_many :observations

  has_many :visit_stores
  has_many :stores, through: :visit_stores

  before_validation :sync_provider
  after_save :save_visit_stores

  validates :tel, numericality: { allow_blank: true }, length: { in: 9..15 }
  validates :password, presence: true, if: :should_validate_password?
  validates :email, uniqueness: true, unless: :common_email?
  validates :visit_store_ids, allow_nil: true, visit_store: true

  # TODO: デフォルトで、joinが走るようにする
  scope :join_size, -> {
    left_joins(:size).select("sizes.name as size_name")
  }

  scope :join_tables, -> {
    select('customers.*').join_size
  }

  scope :like_name, ->(name) {
    where("concat(last_name, first_name) like ?", "%#{name}%") if name.present?
  }

  scope :like_kana_name, ->(kana_name) {
    where("concat(last_kana, first_kana) collate utf8_unicode_ci like ?", "%#{kana_name}%") if kana_name.present?
  }

  scope :like_tel, ->(tel) {
    where('tel LIKE ?', "%#{tel}%") if tel.present?
  }

  scope :like_email, ->(email) {
    where('email LIKE ?', "%#{email}%") if email.present?
  }

  scope :where_deleted, ->(is_deleted) {
    where(is_deleted: is_deleted)
  }

  scope :group_duplicated, ->(columns) {
    group(columns).having('count(*) >= 2')
  }

  attr_accessor :age, :display_email, :visit_store_ids

  def self.merge(merge_from_id, merge_to_id)
    merge_from_customer = find(merge_from_id)
    merge_from_customer.reservations.update(customer_id: merge_to_id)

    merge_to_customer = find(merge_to_id)

    if !merge_to_customer.member? && merge_from_customer.member?
      merge_to_customer.uid = merge_from_customer.uid
      merge_to_customer.encrypted_password = merge_from_customer.encrypted_password
      merge_to_customer.provider = 'email'
    end

    merge_from_customer.update!(is_deleted: true)
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

  def full_kana
    return self.last_kana + ' ' + self.first_kana
  end

  def display_email
    return self.email if self.new_record?

    return self.email.nil? ? self.common_email : self.email
  end

  def display_email=(email)
    self.email = email unless email === self.common_email
    self.email = nil if email === self.common_email
  end

  def common_email?
    return self.email.nil? if self.new_record?

    return self.display_email === self.common_email
  end

  def member?
    return self.provider != 'none'
  end

  def save_visit_stores
    return unless visit_store_ids

    self.visit_stores.delete_all
    (visit_store_ids - ['', nil]).each { |id| self.visit_stores.build(store_id: id).save! }
  end

  protected

  # 会員かつ、メールアドレスが変更された場合、パスワードをチェックする
  def should_validate_password?
    # nilからの変更は、changed? === trueとして認識されないため、下記の様に確認
    return self.member? && self.email != self.email_was
  end

  def sync_provider
    self.provider = self.common_email? ? 'none' : 'email'
    self.uid = self.common_email? ? SecureRandom.uuid : self.email

    # パスワードの再設定を必要にするため
    self.encrypted_password = nil if self.common_email?
  end

  def common_email
    return Settings.customer.common_email
  end
end
