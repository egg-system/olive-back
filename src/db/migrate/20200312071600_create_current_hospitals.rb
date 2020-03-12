class CreateCurrentHospitals < ActiveRecord::Migration[5.2]
  def change
    create_table :current_hospitals do |t|

      t.timestamps
    end
  end
end
