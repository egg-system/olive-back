Exercise.where(id: 1).first_or_create!(name: '全くしない')
Exercise.where(id: 2).first_or_create!(name: 'たまにする')
Exercise.where(id: 3).first_or_create!(name: 'よくする')
Exercise.where(id: 4).first_or_create!(name: '非常によくする')
Exercise.where(id: 5).first_or_create!(name: 'その他')
