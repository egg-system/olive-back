CouponType.where(id: 1).first_or_create!(name:'施術')
CouponType.where(id: 2).first_or_create!(name:'インデプス')
CouponType.where(id: 3).first_or_create!(name:'ブライダルエステ')

Coupon.where(id: 1).first_or_create!(name:'施術5回券', coupon_type_id: 1, fee:29167, count:5, start_at:'2019-01-01')
Coupon.where(id: 2).first_or_create!(name:'施術10回券', coupon_type_id: 1, fee:58334, count:10, start_at:'2019-01-01')
Coupon.where(id: 3).first_or_create!(name:'インデプス11回券', coupon_type_id: 2, fee:20000, count:11, start_at:'2019-01-01')
Coupon.where(id: 4).first_or_create!(name:'シンプルプラン', coupon_type_id: 3, fee:30000, count:5, start_at:'2019-01-01')
Coupon.where(id: 5).first_or_create!(name:'エレガントプラン', coupon_type_id: 3, fee:60000, count:10, start_at:'2019-01-01')
Coupon.where(id: 6).first_or_create!(name:'デラックスプラン', coupon_type_id: 3, fee:90000, count:15, start_at:'2019-01-01')
Coupon.where(id: 7).first_or_create!(name:'ラグジュアリープラン', coupon_type_id: 3, fee:126000, count:20, start_at:'2019-01-01')

