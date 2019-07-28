# frozen_string_literal: true

json.extract! coupon_history, :id, :created_at, :updated_at
json.url coupon_history_url(coupon_history, format: :json)
