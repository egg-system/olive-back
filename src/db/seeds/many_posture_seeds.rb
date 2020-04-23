ManyPosture.where(id: 1).first_or_create!(name: '座っている')
ManyPosture.where(id: 2).first_or_create!(name: '立ち仕事')
ManyPosture.where(id: 3).first_or_create!(name: '歩き回る')
ManyPosture.where(id: 4).first_or_create!(name: 'その他')