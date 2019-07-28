# frozen_string_literal: true

json.array! @stores, partial: 'stores/store', as: :store
