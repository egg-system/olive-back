class CreateCouponTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :coupon_types do |t|
      t.string :name
      t.string :type_code, index: { unique: true }

      t.timestamps
    end
  end
end
