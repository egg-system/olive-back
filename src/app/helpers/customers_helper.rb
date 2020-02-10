module CustomersHelper
  def duplicated_customer_exists?()
    return Customer.group_duplicate.exists
  end
end
