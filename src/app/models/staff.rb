class Staff < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :rememberable, 
    authentication_keys: [:login, :store_id]
         
  has_many :skill, through: :staffs_skill 
  belongs_to :store
  has_many :shift
  belongs_to :role
end