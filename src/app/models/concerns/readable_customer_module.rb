module ReadableCustomerModule
  extend ActiveSupport::Concern

  def readable_customers
    case self.role.id
    when Role::ADMIN
      return Customer.all
    when Role::HEAD
      return Customer.all
    else
      store_ids = Store.where(store_type: self.stores.pluck(:store_type)).pluck(:id).uniq
      customer_ids = VisitStore.where(store_id: store_ids).pluck(:customer_id).uniq
      return Customer.where(id: customer_ids)
    end
  end
end
