# frozen_string_literal: true

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

  # left join
  scope :join_size, lambda {
    left_joins(:size).select('sizes.name as size_name')
  }

  scope :join_tables, lambda {
    select('customers.*').join_size
  }

  scope :like_name, lambda { |name|
    where('concat(last_name, first_name) like ?', "%#{name}%")
  }

  attr_accessor :age

  def age
    return nil if birthday.nil?

    (Date.today.strftime('%Y%m%d').to_i - birthday.strftime('%Y%m%d').to_i) / 10_000
  end

  def full_name
    last_name + ' ' + first_name
  end

  protected

  def member?
    provider != 'none'
  end

  def is_none_provider?
    provider === 'none'
  end

  def sync_none_uid
    self.uid = Time.zone.now.to_s if is_none_provider?
  end
end
