class NearStoreOption < ApplicationRecord
  belongs_to :store
  belongs_to :near_store, class_name: 'Store'
end
