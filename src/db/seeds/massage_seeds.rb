Massage.where(id: 1).first_or_create!(name: '初めて')
Massage.where(id: 2).first_or_create!(name: 'たまに行く')
Massage.where(id: 3).first_or_create!(name: 'よく行く')
Massage.where(id: 4).first_or_create!(name: '非常によく行く')
Massage.where(id: 5).first_or_create!(name: 'その他')
