class CreateCurrentHospitalMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :current_hospital_menus do |t|
      t.string :name
      t.timestamps
    end
  end
end
