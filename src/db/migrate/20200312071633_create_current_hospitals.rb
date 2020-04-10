class CreateCurrentHospitals < ActiveRecord::Migration[5.2]
  def change
    create_table :current_hospitals do |t|
      t.string :name
      t.timestamps
    end
  end
end
