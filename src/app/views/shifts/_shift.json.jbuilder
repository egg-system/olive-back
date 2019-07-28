# frozen_string_literal: true

json.extract! shift, :id, :created_at, :updated_at
json.url shift_url(shift, format: :json)
