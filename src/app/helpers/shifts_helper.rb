module ShiftsHelper
	def extract_date(shift_time)
		return shift_time.strftime('%Y-%m-%d')
	end

	def extract_shift(date, shift_time)
		return @date_shifts[date].find { |shift|
			shift.shift_at.strftime('%Y%m%d%H%M') === shift_time.strftime('%Y%m%d%H%M')
		} 
  end

	def get_shift_parameter(shift_time)
		return "new_shifts[#{shift_time}]" unless shift_exist(shift_time)

		date = extract_date(shift_time)
		shift = extract_shift(date, shift_time)
		return "remain_shift_ids[#{shift.id}]"
  end
  
  def get_weekday(shift_date)
    date = shift_date
    date = Date.parse(shift_date) if shift_date.is_a?(String)

    return date.wday
  end

  def get_weekday_label(shift_date)
    week_day = get_weekday(shift_date)
    return I18n.t('date.abbr_day_names')[week_day]
  end

  def weekend?(shift_date)
    # rubyのwdayでは、土曜日が6、日曜日が0になる
    return [0,6].include? get_weekday(shift_date)
  end

	def resrvation_exist(shift_time)
		date = extract_date(shift_time)
		return false unless shift_exist(shift_time)
		
		return extract_shift(date, shift_time).reserved
	end
	
	def shift_exist(shift_time)
		date = extract_date(shift_time)
		return false unless @date_shifts.has_key?(date)

		return extract_shift(date, shift_time).present?
	end
end
