# frozen_string_literal: true

class StoreMenu < ApplicationRecord
  belongs_to :store
  belongs_to :menu
end
