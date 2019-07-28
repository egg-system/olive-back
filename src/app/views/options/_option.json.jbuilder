# frozen_string_literal: true

json.extract! option, :id, :created_at, :updated_at
json.url option_url(option, format: :json)
