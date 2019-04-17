class DeviseTokenAuthCreateCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :provider, :string, null: false, default: 'email'
    add_column :customers, :uid, :string, null: false, default: ''
    add_column :customers, :tokens, :text

    Customer.reset_column_information
    add_index :customers, [:uid, :provider], unique: true
  end
end
