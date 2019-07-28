# frozen_string_literal: true

class SkillMenu < ApplicationRecord
  belongs_to :menu
  belongs_to :skill
end
