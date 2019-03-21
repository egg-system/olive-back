class CreatePregnantStates < ActiveRecord::Migration[5.1]
  def change
    create_table :pregnant_states do |t|
      t.text :name
      t.timestamps
    end
  end
end
