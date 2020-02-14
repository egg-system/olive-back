module CustomersHelper
  def duplicated_customer_views(customers)
    result = []
    if customers.first.first_kana === customers.second.first_kana && customers.first.last_kana === customers.second.last_kana
      result.push({ name: Settings.duplicated_customer.kana.name, value: customers.first.full_kana })
    end
    if customers.first.tel === customers.second.tel
      result.push({ name: Settings.duplicated_customer.tel.name, value: customers.first.tel })
    end
    result
  end
end
