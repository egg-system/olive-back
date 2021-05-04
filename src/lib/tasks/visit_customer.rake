namespace :visit_customer do
  desc '経過記録を元に来店情報を作成する'
  task create: :environment do
    Customer.all.includes(:observations, :visit_stores).each do |customer|
      customer.visit_stores.delete_all
      store_ids = customer.observations.pluck(:store_id).uniq
      store_ids.each do |store_id|
        customer.visit_stores.build(store_id: store_id).save
      end
    end
  end
end
