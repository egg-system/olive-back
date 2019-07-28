# frozen_string_literal: true

class SkillStaff < ApplicationRecord
  belongs_to :staff
  belongs_to :skill
end
