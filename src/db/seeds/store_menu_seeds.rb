Department.where(id: 1).first_or_create!(name:'施術')
Department.where(id: 2).first_or_create!(name:'エステ')

MenuCategory.where(id: 1).first_or_create!(name:'整体・マッサージ', department_id:1)
MenuCategory.where(id: 2).first_or_create!(name:'鍼灸', department_id:1)
MenuCategory.where(id: 3).first_or_create!(name:'交通事故治療', department_id:1)
MenuCategory.where(id: 4).first_or_create!(name:'不妊治療', department_id:1)
MenuCategory.where(id: 5).first_or_create!(name:'エステ', department_id:2)
MenuCategory.where(id: 6).first_or_create!(name:'ブライダルエステ', department_id:2)
MenuCategory.where(id: 7).first_or_create!(name:'オプション', department_id:1)

Menu.where(id: 1).first_or_create!(name:'初診・問診', fee:1000, service_minutes:0, start_at:'2019-01-01', menu_category_id:7)
Menu.where(id: 2).first_or_create!(name:'初通常整体コース', fee:6000, service_minutes:60, start_at:'2019-01-01', menu_category_id:1)
Menu.where(id: 3).first_or_create!(name:'整体スペシャルパックコース', fee:25000, service_minutes:120, start_at:'2019-01-01', menu_category_id:1)
Menu.where(id: 4).first_or_create!(name:'足つぼ', fee:2000, service_minutes:0, start_at:'2019-01-01', menu_category_id:7)
Menu.where(id: 5).first_or_create!(name:'小顔矯正', fee:4000, service_minutes:0, start_at:'2019-01-01', menu_category_id:7)
Menu.where(id: 6).first_or_create!(name:'骨盤矯正', fee:6000, service_minutes:60, start_at:'2019-01-01', menu_category_id:1)
Menu.where(id: 7).first_or_create!(name:'マッサージ', fee:6000, service_minutes:60, start_at:'2019-01-01', menu_category_id:1)
Menu.where(id: 8).first_or_create!(name:'テーピング', fee:2000, service_minutes:0, start_at:'2019-01-01', menu_category_id:1)
Menu.where(id: 9).first_or_create!(name:'インデプス', fee:2000, service_minutes:0, start_at:'2019-01-01', menu_category_id:1)
Menu.where(id: 10).first_or_create!(name:'産後の骨盤矯正', fee:6000, service_minutes:60, start_at:'2019-01-01', menu_category_id:1)
Menu.where(id: 11).first_or_create!(name:'通常鍼灸（マッサージ有）', fee:6000, service_minutes:60, start_at:'2019-01-01', menu_category_id:2)
Menu.where(id: 12).first_or_create!(name:'特別鍼灸（マッサージ無）', fee:6000, service_minutes:60, start_at:'2019-01-01', menu_category_id:2)
Menu.where(id: 13).first_or_create!(name:'本治療', fee:2000, service_minutes:0, start_at:'2019-01-01', menu_category_id:7)
Menu.where(id: 14).first_or_create!(name:'耳つぼ', fee:2000, service_minutes:0, start_at:'2019-01-01', menu_category_id:7)
Menu.where(id: 15).first_or_create!(name:'耳つぼジュエリー', fee:500, service_minutes:0, start_at:'2019-01-01', menu_category_id:7)
Menu.where(id: 16).first_or_create!(name:'赤ちゃん鍼', fee:1000, service_minutes:0, start_at:'2019-01-01', menu_category_id:7)
Menu.where(id: 17).first_or_create!(name:'置鍼', fee:300, service_minutes:0, start_at:'2019-01-01', menu_category_id:7)
Menu.where(id: 18).first_or_create!(name:'交通事故治療', fee:0, service_minutes:60, start_at:'2019-01-01', menu_category_id:3)
Menu.where(id: 19).first_or_create!(name:'不妊治療（整体）', fee:6000, service_minutes:60, start_at:'2019-01-01', menu_category_id:4)
Menu.where(id: 20).first_or_create!(name:'不妊治療（鍼灸）', fee:6000, service_minutes:60, start_at:'2019-01-01', menu_category_id:4)
Menu.where(id: 21).first_or_create!(name:'初回カウンセリング', fee:1000, service_minutes:0, start_at:'2019-01-01', menu_category_id:7)
Menu.where(id: 22).first_or_create!(name:'上半身メインコース', fee:6000, service_minutes:60, start_at:'2019-01-01', menu_category_id:5)
Menu.where(id: 23).first_or_create!(name:'下半身メインコース', fee:6000, service_minutes:60, start_at:'2019-01-01', menu_category_id:5)
Menu.where(id: 24).first_or_create!(name:'全身コース', fee:6000, service_minutes:60, start_at:'2019-01-01', menu_category_id:5)
Menu.where(id: 25).first_or_create!(name:'フェイシャルメインコース', fee:6000, service_minutes:60, start_at:'2019-01-01', menu_category_id:5)
Menu.where(id: 26).first_or_create!(name:'ダブルメインコース', fee:12000, service_minutes:120, start_at:'2019-01-01', menu_category_id:6)
Menu.where(id: 27).first_or_create!(name:'シンプルプラン', fee:30000, service_minutes:0, start_at:'2019-01-01', menu_category_id:6)
Menu.where(id: 28).first_or_create!(name:'エレガントプラン', fee:60000, service_minutes:0, start_at:'2019-01-01', menu_category_id:6)
Menu.where(id: 29).first_or_create!(name:'デラックスプラン', fee:90000, service_minutes:0, start_at:'2019-01-01', menu_category_id:6)
Menu.where(id: 30).first_or_create!(name:'ラグジュアリープラン', fee:126000, service_minutes:0, start_at:'2019-01-01', menu_category_id:6)

Skill.where(id: 1).first_or_create!(name:'柔道整体師')
Skill.where(id: 2).first_or_create!(name:'柔道整体師兼鍼灸師')

Skill.all.each do |skill|
  Menu.all.each do |menu|
    SkillMenu.where(skill_id: skill.id, menu_id: menu.id).first_or_create!()
  end
end

Store.where(id: 1).first_or_create!(
  store_type:0, 
  name:'女性専門の治療院オリーヴボディケア　たまプラーザ店', 
  address:'横浜市青葉区新石川3-15-16　メディカルモールたまプラーザ301', 
  tel:'045-530-1688', 
  mail:'gaku.machida@gmail.com', 
  url:'https://olivebodycare.jp/', 
  open_at:'10:00', 
  close_at: '20:00'
)

Menu.all.each do |menu|
  StoreMenu.where(store_id: 1, menu_id: menu.id).first_or_create!()
end