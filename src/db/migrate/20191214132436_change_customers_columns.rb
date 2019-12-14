class ChangeCustomersColumns < ActiveRecord::Migration[5.2]
  def change
    change_column :customers, :email, :string, default: "test@test.com"

    Customer.all.each { |customer|
      customer.update_attributes(email: "test@test.com") if !customer.email.present?
    }
  end
end
