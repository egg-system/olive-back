# frozen_string_literal: true

json.extract! role, :id, :created_at, :updated_at
json.url role_url(role, format: :json)
