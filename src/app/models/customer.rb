class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,

        :recoverable, :rememberable

  include DeviseTokenAuth::Concerns::User

  belongs_to :first_visit_store, optional: true, class_name: 'Store', foreign_key: 'first_visit_store_id'
  belongs_to :last_visit_store, optional: true, class_name: 'Store', foreign_key: 'last_visit_store_id'

  belongs_to :job_type, optional: true
  belongs_to :zoomancy, optional: true
  belongs_to :baby_age, optional: true
  belongs_to :size, optional: true
  belongs_to :visit_reason, optional: true
  belongs_to :nearest_station, optional: true

  has_many :reservations

  before_validation :sync_none_uid

  after_commit :send_register_mail, on: :create

  #left join
  scope :join_size, ->{
    left_joins(:size).select("sizes.name as size_name")
  }

  scope :join_tables, ->{
    select('customers.*').join_size
  }

  scope :like_name, ->(name){
    where("concat(last_name, first_name) like ?", "%#{name}%")
  }

  attr_accessor :age, :should_send_mail

  after_initialize do
    self.should_send_mail = true
  end

  def age
    return nil if self.birthday.nil?
    return (Date.today.strftime('%Y%m%d').to_i - self.birthday.strftime('%Y%m%d').to_i) / 10000
  end

  protected

  def is_none_provider?
    provider === 'none'
  end

  def sync_none_uid
    self.uid = Time.now.to_s if is_none_provider?
  end

  private
  def send_register_mail
    unless self.should_send_mail
      return
    end

    CustomerMailer.confirm_register(self).deliver_now
  end
end

