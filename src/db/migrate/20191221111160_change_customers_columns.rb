class ChangeCustomersColumns < ActiveRecord::Migration[5.2]
  def change
    change_column :customers, :email, :string, null: true, default: nil

    Customer.where(email: ['', Settings.customer.common_email]).each { |customer|
      customer.email = nil
      customer.save!(validate: false)
    }
  end
end
