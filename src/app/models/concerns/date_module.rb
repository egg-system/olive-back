module DateModule
  def get_month_range(start_month, end_month = nil)
    start_date = Date.parse("#{start_month}-01")
    end_date = Date.parse("#{start_month}-01").end_of_month

    end_date = Date.parse("#{end_month}-01").end_of_month unless end_month.nil?

    # 書式をそろえるため、一度Date型に変換している
    start_date_string = start_date.strftime('%Y-%m-%d')
    end_date_string = end_date.strftime('%Y-%m-%d')

    return start_date_string, end_date_string
  end

  def is_same_day(standard_day, compare_day)
    on_year = standard_day.year === compare_day.year
    on_month = standard_day.month === compare_day.month
    on_day = standard_day.day === compare_day.day

    return on_year && on_month && on_day
  end
end
