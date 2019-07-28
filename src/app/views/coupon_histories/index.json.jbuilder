# frozen_string_literal: true

json.array! @coupon_histories, partial: 'coupon_histories/coupon_history', as: :coupon_history
