class ReservationDetail < ApplicationRecord
	belongs_to :reservation
	belongs_to :menu

	has_many :reservation_detail_options
	has_many :options, through: :reservation_detail_options
	accepts_nested_attributes_for :reservation_detail_options, allow_destroy: true

	validates :menu_id, presence: true

	def total_fee
		total_option_fee = self.options.sum { |option|
			total_fee = option.fee

			# 耳つぼジュエリの場合、個数とかけた金額にする
			if option.is_mimitsubo_jewelry
				total_fee = option.fee * self.mimitsubo_count
			end

			total_fee
		}

		return self.menu.fee + total_option_fee
	end

	def has_options
		return self.options.present?
	end

	def option_names
		return self.options.map { |option|
			option_name = option.name

			# 耳つぼジュエリの個数を表記するための実装
			if option.is_mimitsubo_jewelry
				option_name = "#{option.name} × #{self.mimitsubo_count.to_s}個"
			end

			option_name
		}
	end

	MIMITSUBO_JEWELRY_OPTIONS = [2, 4, 6, 8, 10]

end
