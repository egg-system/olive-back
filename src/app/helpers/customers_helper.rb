module CustomersHelper
  def duplicated_customer_alerts
    return Settings.duplicated_customer.to_h.values.map do |item|
      if Customer.group_duplicated(item.columns.map(&:to_s)).exists?
        { message: item.name, columns: item.columns.join(',') }
      end
    end.select { |item| item.present? }
  end

  def duplicated_customer_views(columns, customers)
    columns_str = columns.present? ? columns : ''
    if columns_str === Settings.duplicated_customer.kana.columns.join(',')
      return "カナの<span class='text-danger'>#{customers.first.full_kana}</span>が重複".html_safe
    elsif columns_str === Settings.duplicated_customer.tel.columns.join(',')
      return "電話番号の<span class='text-danger'>#{customers.first.tel}</span>が重複".html_safe
    elsif columns_str === Settings.duplicated_customer.kana_tel.columns.join(',')
      return "カナの<span class='text-danger'>#{customers.first.full_kana}</span>と、電話番号の<span class='text-danger'>#{customers.first.tel}</span>が重複".html_safe
    end
  end
end
