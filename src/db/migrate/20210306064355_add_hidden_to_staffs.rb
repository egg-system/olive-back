class AddHiddenToStaffs < ActiveRecord::Migration[5.2]
  def change
    add_column :staffs, :hidden, :boolean, default: false
  end
end
