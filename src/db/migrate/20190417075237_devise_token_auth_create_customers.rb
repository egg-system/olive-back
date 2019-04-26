class DeviseTokenAuthCreateCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :provider, :string, null: false, default: 'email', comment: '非会員の場合、noneになる'
    add_column :customers, :uid, :string, null: false, default: ''
    add_column :customers, :tokens, :text
    add_column :customers, :allow_password_change, :boolean, default: false, comment: 'パスワード変更に必要'

    Customer.reset_column_information
    add_index :customers, [:uid, :provider], unique: true
  end
end
