Size.where(id: 1).first_or_create(size_id: 0, name:'')
Size.where(id: 2).first_or_create(size_id: 1, name:'未入 ')
Size.where(id: 3).first_or_create(size_id: 2, name:'S ')
Size.where(id: 4).first_or_create(size_id: 3, name:'S〜M ')
Size.where(id: 5).first_or_create(size_id: 4, name:'M ')
Size.where(id: 6).first_or_create(size_id: 5, name:'M〜L ')
Size.where(id: 7).first_or_create(size_id: 6, name:'L ')
Size.where(id: 8).first_or_create(size_id: 7, name:'XL ')