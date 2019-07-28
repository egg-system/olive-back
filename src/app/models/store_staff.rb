# frozen_string_literal: true

class StoreStaff < ApplicationRecord
  belongs_to :store
  belongs_to :staff
end
