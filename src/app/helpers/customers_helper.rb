module CustomersHelper
  def duplicated_customer_alerts
    return Settings.duplicated_customer.to_h.values.map { |item|
      if Customer.group_duplicated(item[:columns]).exists?
        { message: item[:name], columns: item[:columns] }
      end
    }.select(&:present?)
  end

  def duplicated_customer_views(customers)
    # 重複していない場合、全てのfull_kana or telはバラバラになるため、count > 1になる
    duplicated_kana = customers.map(&:full_kana).uniq.count === 1 ? customers.first.full_kana : nil
    duplicated_tel = customers.map(&:tel).uniq.count === 1 ? customers.first.tel : nil

    return render 'customers/duplicate/heading', { kana: duplicated_kana, tel: duplicated_tel }
  end

  def synced_square_customer_message(customer)
    return '' unless customer.square_customer_exists?
    return '' if @customer.synced_square_customer?

    return 'squareのデータと管理画面のデータに差分があります。詳細をご確認ください。'
  end
end
