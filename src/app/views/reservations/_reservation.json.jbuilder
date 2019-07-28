# frozen_string_literal: true

json.extract! reservation, :id, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
