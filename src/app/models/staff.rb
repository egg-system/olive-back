class Staff < ApplicationRecord
  acts_as_paranoid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :rememberable, 
    authentication_keys: [:login, :store_id]

  has_many :staffs_skill
  has_many :skill, through: :staffs_skill 
  belongs_to :store
  has_many :shift
  belongs_to :role
  accepts_nested_attributes_for :staffs_skill


  #店舗idによる絞り込み
  scope :get_by_store, ->(store_id){
    where(store_id: store_id)
  }

  #left join
  scope :join_store, ->{
    left_joins(:store).select("stores.name as store_name")
  }
  scope :join_role, ->{
       left_joins(:role).select("roles.name as role_name")
  }

  scope :join_tables, ->{
    select('staffs.*').join_store.join_role
  }

end