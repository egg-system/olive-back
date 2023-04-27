class AddIndexColumnToMenuOptionTables < ActiveRecord::Migration[6.1]
  def change
    add_column :menus, :index, :integer, after: :fee
    add_column :options, :index, :integer, after: :fee

    Menu.all.each_with_index do |menu, index|
      menu.update_attribute(:index, index + 1)
    end

    Option.all.each_with_index do |option, index|
      option.update_attribute(:index, index + 1)
    end

    change_column_null :menus, :index, false
    change_column_null :options, :index, false
  end
end
