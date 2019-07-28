# frozen_string_literal: true

json.extract! skill, :id, :created_at, :updated_at
json.url skill_url(skill, format: :json)
