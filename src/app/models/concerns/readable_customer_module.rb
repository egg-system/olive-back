module ReadableCustomerModule
  extend ActiveSupport::Concern

  def readable_customers
    customers = Customer.enabled
    case role.id
    when Role::ADMIN
      return customers
    when Role::HEAD
      return customers if stores.pluck(:store_type).include?(:owned)

      store_ids = Store.where(store_type: stores.pluck(:store_type)).pluck(:id).uniq
      customer_ids = VisitStore.where(store_id: store_ids).pluck(:customer_id).uniq
      return customers.where(id: customer_ids)
    else
      store_ids = Store.where(store_type: stores.pluck(:store_type)).pluck(:id).uniq
      customer_ids = VisitStore.where(store_id: store_ids).pluck(:customer_id).uniq
      return customers.where(id: customer_ids)
    end
  end
end
