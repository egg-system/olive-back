# frozen_string_literal: true

Tax.where(id: 1).first_or_create!(rate: 1.00)
Tax.where(id: 2).first_or_create!(rate: 1.08, is_default: true)
Tax.where(id: 3).first_or_create!(rate: 1.10)
