# frozen_string_literal: true

class Staff < ApplicationRecord
  acts_as_paranoid

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :rememberable, authentication_keys: [:login]

  has_many :skill_staffs
  has_many :skills, through: :skill_staffs
  accepts_nested_attributes_for :skill_staffs, update_only: true

  validates :skill_staffs, presence: true
  validates :first_kana, full_width_kana: true
  validates :last_kana, full_width_kana: true

  has_many :store_staffs
  has_many :stores, through: :store_staffs
  accepts_nested_attributes_for :skill_staffs, update_only: true
  validates :skill_staffs, presence: true

  belongs_to :role
  has_many :shifts

  scope :can_treats, lambda { |menu_ids, option_ids|
    menus = Menu.where(id: menu_ids).select('skill_id').distinct
    must_skill_ids = menus.map(&:skill_id)

    if option_ids.present?
      options = Option.where(id: option_ids).select('skill_id').distinct
      option_must_skill_ids = options.map(&:skill_id)
      must_skill_ids = must_skill_ids.concat(option_must_skill_ids).uniq
    end

    return has_must_skills(must_skill_ids)
  }

  # 全部のスキルを持っているスタッフで絞りこむ
  scope :has_must_skills, lambda { |skill_ids|
    staffIds = SkillStaff
               .where(skill_id: skill_ids)
               .group(:staff_id)
               .having('count(skill_id) >= ?', skill_ids.count)
               .select(:staff_id)

    return where(id: staffIds)
  }

  # 店舗idによる絞り込み
  scope :where_store_id, lambda { |store_id|
    joins(:stores).merge(Store.where(id: store_id))
  }

  scope :join_role, lambda {
    left_joins(:role).select('roles.name as role_name')
  }

  scope :join_tables, lambda {
    select('staffs.*').join_role
  }

  def full_name
    (last_name + ' ' + first_name).strip
  end

  def employment_type_name
    return '' if employment_type.nil?

    Settings.employment_type[employment_type]
  end

  def name
    "#{last_name} #{first_name}"
  end

  def self.find_for_authentication(tainted_conditions)
    # TODO: ここで店舗の検索処理を実装する
    super
  end
end
