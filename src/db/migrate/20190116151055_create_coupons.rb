class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :fee, comment: '税別料金'
      t.integer :count, comment: '利用回数'
      t.date :start_at
      t.date :end_at
      t.date :expired_at

      t.timestamps
    end
  end
end
