Coupon.where(id: 1).first_or_create!(name:'施術5回券', fee:29167, count:5, start_at:'2019-01-01')
Coupon.where(id: 2).first_or_create!(name:'施術10回券', fee:58334, count:10, start_at:'2019-01-01')
Coupon.where(id: 3).first_or_create!(name:'インデプス11回券', fee:20000, count:11, start_at:'2019-01-01')