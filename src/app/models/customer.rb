class Customer < ApplicationRecord
  attr_accessor :age
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  belongs_to :first_visit_store, class_name: 'Store', foreign_key: 'first_visit_store_id'
  belongs_to :last_visit_store, class_name: 'Store', foreign_key: 'last_visit_store_id'

  belongs_to :job_type, optional: true
  belongs_to :zoomancy, optional: true
  belongs_to :baby_age, optional: true
  belongs_to :size, optional: true
  belongs_to :visit_reason, optional: true
  belongs_to :nearest_station, optional: true

  #left join
  scope :join_size, ->{
    left_joins(:size).select("sizes.name as size_name")
  }

  scope :join_tables, ->{
    select('customers.*').join_size
  }
end
