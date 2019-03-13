class AddCustomersForignKeys < ActiveRecord::Migration[5.2]
  def change
    add_reference :customers, :job_type, foreign_key: true, default: nil, null: true
    add_reference :customers, :zoomancy, foreign_key: true, default: nil, null: true
    add_reference :customers, :baby_age, foreign_key: true, default: nil, null: true
    add_reference :customers, :size, foreign_key: true, default: nil, null: true
    add_reference :customers, :visit_reason, foreign_key: true, default: nil, null: true
    add_reference :customers, :nearest_station, foreign_key: true, default: nil, null: true
  end
end
