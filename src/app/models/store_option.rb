# frozen_string_literal: true

class StoreOption < ApplicationRecord
  belongs_to :store
  belongs_to :option
end
