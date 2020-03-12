class CreateHopeTherapies < ActiveRecord::Migration[5.2]
  def change
    create_table :hope_therapies do |t|

      t.timestamps
    end
  end
end
