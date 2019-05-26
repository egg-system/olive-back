module ShiftsHelper
	def extract_date(shift_time)
		return shift_time.strftime('%Y-%m-%d')
	end

	def extract_shift(date, shift_time)
		return @date_shifts[date].find { |shift|
			shift.shift_at.strftime('%Y%m%d%H%M') === shift_time.strftime('%Y%m%d%H%M')
		} 
	end
	
	def shift_exist(shift_time)
		date = extract_date(shift_time)
		return false unless @date_shifts.has_key?(date)

		return extract_shift(date, shift_time).present?
	end

	def resrvation_exist(shift_time)
		date = extract_date(shift_time)
		return false unless shift_exist(shift_time)
		
		return extract_shift(date, shift_time).reserved
	end

	def get_shift_parameter(shift_time)
		return "new_shifts[#{shift_time}]" unless shift_exist(shift_time)

		date = extract_date(shift_time)
		shift = extract_shift(date, shift_time)
		return "remain_shift_ids[#{shift.id}]"
	end
end
