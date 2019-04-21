class CreateCoupons < ActiveRecord::Migration[5.1]
  def change
    create_table :coupons do |t|
      t.references :coupon_type, foreign_key: true
      t.string :name
      t.string :fee, comment: '税別料金'
      t.integer :count, comment: '利用回数'
      t.date :start_at
      t.date :end_at
      t.integer :months_to_expire

      t.timestamps
    end
  end
end
