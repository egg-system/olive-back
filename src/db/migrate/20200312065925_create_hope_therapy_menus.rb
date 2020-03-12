class CreateHopeTherapyMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :hope_therapy_menus do |t|
      t.string :name
      t.timestamps
    end
  end
end
