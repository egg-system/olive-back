module DateModule
  def get_month_range(start_month, end_month = nil)
    start_date = Date.parse("#{start_month}-01")
    end_date = Date.parse("#{start_month}-01").end_of_month
    
    unless end_month.nil?
      end_date = Date.parse("#{end_month}-01").end_of_month
    end

    # 書式をそろえるため、一度Date型に変換している
    start_date_string = start_date.strftime('%Y-%m-%d')
    end_date_string = end_date.strftime('%Y-%m-%d')
    
    return start_date_string, end_date_string
  end

  def isSameDay(standardDay, compareDay)
    on_year = standardDay.year === compareDay.year
    on_month = standardDay.month === compareDay.month
    on_day = standardDay.day === compareDay.day
    
    return on_year && on_month && on_day
  end
end