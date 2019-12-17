class ChangeCustomersColumns < ActiveRecord::Migration[5.2]
  def change
    change_column :customers, :email, :string, null: false

    Customer.where(email: [nil, '']).each { |customer|
      customer.update_attributes(email: "common.mail@olivebodycare.healthcare")
    }
  end
end
