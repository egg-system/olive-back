class CreateHopeMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :hope_menus do |t|
      t.string :name
      t.timestamps
    end
  end
end
