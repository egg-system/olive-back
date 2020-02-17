module CustomersHelper
  def duplicated_customer_alerts
    return Settings.duplicated_customer.to_h.values.map { |item|
      if Customer.group_duplicated(item.columns).exists?
        { message: item.name, columns: item.columns }
      end
    }.select(&:present?)
  end

  def duplicated_customer_views(customers)
    # 重複していない場合、全てのfull_kana or telはバラバラになるため、count > 1になる
    duplicated_kana = customers.map(&:full_kana).uniq.count === 1
    duplicated_tel = customers.map(&:tel).uniq.count === 1

    if duplicated_kana && duplicated_tel
      return "カナの<span class='text-danger'>
          #{customers.first.full_kana}
        </span>と、電話番号の<span class='text-danger'>
          #{customers.first.tel}
        </span>が重複".html_safe
    end

    if duplicated_kana
      return "カナの<span class='text-danger'>#{customers.first.full_kana}</span>が重複".html_safe
    end

    if duplicated_tel
      return "電話番号の<span class='text-danger'>#{customers.first.tel}</span>が重複".html_safe
    end
  end
end
