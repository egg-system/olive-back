class ChangeCustomersColumns < ActiveRecord::Migration[5.2]
  def change
    change_column :customers, :email, :string, default: "common.mail@olivebodycare.healthcare"

    Customer.all.each { |customer|
      customer.update_attributes(email: "common.mail@olivebodycare.healthcare") if !customer.email.present?
    }
  end
end
