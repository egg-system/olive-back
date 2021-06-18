namespace :visit_customer do
  desc '予約を元に来店情報を作成する'
  task create: :environment do
    owned_store_ids = Store.where(store_type: :owned).pluck(:id).uniq
    Customer.all.includes(:reservations, :visit_stores).each do |customer|
      customer.visit_stores.delete_all
      owned_store = false
      store_ids = customer.reservations.pluck(:store_id).uniq
      store_ids.each do |store_id|
        customer.visit_stores.build(store_id: store_id).save
        next if owned_store

        owned_store = true if owned_store_ids.include?(store_id)
      end
      next unless owned_store

      (owned_store_ids - store_ids).each do |store_id|
        customer.visit_stores.build(store_id: store_id).save
      end
    end
  end
end
