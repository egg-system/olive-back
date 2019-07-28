# frozen_string_literal: true

class Department < ApplicationRecord
  has_many :menu_category
end
