# frozen_string_literal: true

json.array! @shifts, partial: 'shifts/shift', as: :shift
