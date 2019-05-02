class Staff < ApplicationRecord
  acts_as_paranoid

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :rememberable,
    authentication_keys: [:login, :store_id]

  has_many :skill_staff
  has_many :skills, through: :skill_staff
  accepts_nested_attributes_for :skill_staff, update_only: true

  belongs_to :store
  belongs_to :role

  has_many :shifts

  def occupation_type_name
    if self.employment_type.nil?
        return ""
    end
    return Settings.employment_type[self.employment_type]
  end

  scope :can_treats, -> (menu_ids, option_ids) {
    menus = Menu.where(id: menu_ids).select('skill_id').distinct
    must_skill_ids = menus.map { |menu| menu.skill_id }

    unless option_ids.blank?
      options = Option.where(id: option_ids).select('skill_id').distinct
      option_must_skill_ids = options.map{ |option| option.skill_id }
      must_skill_ids = must_skill_ids.concat(option_must_skill_ids).uniq
    end

    return has_must_skills(must_skill_ids)
  }

  # 全部のスキルを持っているスタッフで絞りこむ
  scope :has_must_skills, -> (skill_ids) {
    staffIds = SkillStaff.where(skill_id: skill_ids)
      .group(:staff_id)
      .having('count(skill_id) >= ?', skill_ids.count)
      .select(:staff_id)

    return where(id: staffIds)
  }

  #店舗idによる絞り込み
  scope :get_by_store, -> (store_id) {
    where(store_id: store_id)
  }

  #left join
  scope :join_store, -> {
    left_joins(:store).select("stores.name as store_name")
  }

  scope :join_role, -> {
    left_joins(:role).select("roles.name as role_name")
  }

  scope :join_tables, -> {
    select('staffs.*').join_store.join_role
  }

  def name
    return "#{self.last_name} #{self.first_name}"
  end
end
