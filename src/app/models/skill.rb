# frozen_string_literal: true

class Skill < ApplicationRecord
  has_many :staffs, through: :staffs_skill
  has_many :menus, through: :skill_menu
end
