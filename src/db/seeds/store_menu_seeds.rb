Department.where(id: 1).first_or_create!(name: '施術')
Department.where(id: 2).first_or_create!(name: 'エステ')

MenuCategory.where(id: 1).first_or_create!(name: '整体・マッサージ', department_id: 1)
MenuCategory.where(id: 2).first_or_create!(name: '鍼灸', department_id: 1)
MenuCategory.where(id: 3).first_or_create!(name: '交通事故治療', department_id: 1)
MenuCategory.where(id: 4).first_or_create!(name: '不妊治療', department_id: 1)
MenuCategory.where(id: 5).first_or_create!(name: 'エステ', department_id: 2)
MenuCategory.where(id: 6).first_or_create!(name: 'ブライダルエステ', department_id: 2)

Skill.where(id: 1).first_or_create!(name: '柔道整体師')
Skill.where(id: 2).first_or_create!(name: '鍼灸師')

Menu.where(id: 1).first_or_create!(name: '通常整体コース', skill_id: 1, fee: 6000, service_minutes: 60, start_at: '2019-01-01', menu_category_id: 1, index: 18)

# 整体スペシャルパックコースはスキル要件が複雑なため、一旦非表示にする
# Menu.where(id: 2).first_or_create!(name:'整体スペシャルパックコース', skill_id: 1, fee:25000, service_minutes:120, start_at:'2019-01-01', menu_category_id:1)
Menu.where(id: 3).first_or_create!(name: '骨盤矯正', skill_id: 1, fee: 6000, service_minutes: 60, start_at: '2019-01-01', menu_category_id: 1, index: 1)
Menu.where(id: 4).first_or_create!(name: 'マッサージ', skill_id: 1, fee: 6000, service_minutes: 60, start_at: '2019-01-01', menu_category_id: 1, index: 2)
Menu.where(id: 5).first_or_create!(name: '産後の骨盤矯正', skill_id: 1, fee: 6000, service_minutes: 60, start_at: '2019-01-01', menu_category_id: 1, index: 3)
Menu.where(id: 6).first_or_create!(name: '通常鍼灸（マッサージ有）', skill_id: 2, fee: 6000, service_minutes: 60, start_at: '2019-01-01', menu_category_id: 2, index: 4)
Menu.where(id: 7).first_or_create!(name: '特別鍼灸（マッサージ無）', skill_id: 2, fee: 6000, service_minutes: 60, start_at: '2019-01-01', menu_category_id: 2, index: 5)
Menu.where(id: 8).first_or_create!(name: '交通事故治療', skill_id: 1, fee: 0, service_minutes: 60, start_at: '2019-01-01', menu_category_id: 3, index: 6)
Menu.where(id: 9).first_or_create!(name: '不妊治療（整体）', skill_id: 1, fee: 6000, service_minutes: 60, start_at: '2019-01-01', menu_category_id: 4, index: 7)
Menu.where(id: 10).first_or_create!(name: '不妊治療（鍼灸）', skill_id: 2, fee: 6000, service_minutes: 60, start_at: '2019-01-01', menu_category_id: 4, index: 8)

# エステのメニュー
Menu.where(id: 11).first_or_create!(name: '上半身メインコース', skill_id: 1, fee: 6000, service_minutes: 60, start_at: '2019-01-01', menu_category_id: 5, index: 9)
Menu.where(id: 12).first_or_create!(name: '下半身メインコース', skill_id: 1, fee: 6000, service_minutes: 60, start_at: '2019-01-01', menu_category_id: 5, index: 10)
Menu.where(id: 13).first_or_create!(name: '全身コース', skill_id: 1, fee: 6000, service_minutes: 60, start_at: '2019-01-01', menu_category_id: 5, index: 11)
Menu.where(id: 14).first_or_create!(name: 'フェイシャルメインコース', skill_id: 1, fee: 6000, service_minutes: 60, start_at: '2019-01-01', menu_category_id: 5, index: 12)
Menu.where(id: 15).first_or_create!(name: 'ダブルメインコース', skill_id: 1, fee: 12000, service_minutes: 120, start_at: '2019-01-01', menu_category_id: 6, index: 13)
Menu.where(id: 16).first_or_create!(name: 'シンプルプラン', skill_id: 1, fee: 30000, service_minutes: 0, start_at: '2019-01-01', menu_category_id: 6, index: 14)
Menu.where(id: 17).first_or_create!(name: 'エレガントプラン', skill_id: 1, fee: 60000, service_minutes: 0, start_at: '2019-01-01', menu_category_id: 6, index: 15)
Menu.where(id: 18).first_or_create!(name: 'デラックスプラン', skill_id: 1, fee: 90000, service_minutes: 0, start_at: '2019-01-01', menu_category_id: 6, index: 16)
Menu.where(id: 19).first_or_create!(name: 'ラグジュアリープラン', skill_id: 1, fee: 126000, service_minutes: 0, start_at: '2019-01-01', menu_category_id: 6, index: 17)

Option.where(id: 1).first_or_create!(name: '足つぼ', skill_id: 1, fee: 2000, start_at: '2019-01-01', department_id: 1, index: 1, menu_category_ids: [1])
Option.where(id: 2).first_or_create!(name: '小顔矯正', skill_id: 1, fee: 4000, start_at: '2019-01-01', department_id: 1, index: 2, menu_category_ids: [1])
Option.where(id: 3).first_or_create!(name: 'テーピング', skill_id: 1, fee: 2000, start_at: '2019-01-01', department_id: 1, index: 3, menu_category_ids: [1])
# インデプスは機械の台数制約があるため、一旦非表示にする
# Option.where(id: 4).first_or_create!(name:'インデプス', skill_id: 1, fee:2000, start_at:'2019-01-01', department_id:1)
Option.where(id: 5).first_or_create!(name: '本治療', skill_id: 2, fee: 2000, start_at: '2019-01-01', department_id: 1, description: '鍼のオプションのため、鍼につけることはできない', index: 4, menu_category_ids: [1])
Option.where(id: 6).first_or_create!(name: '耳つぼ', skill_id: 1, fee: 2000, start_at: '2019-01-01', department_id: 1, index: 5, menu_category_ids: [1])
Option.where(id: 7).first_or_create!(name: '耳つぼジュエリー', skill_id: 1, fee: 500, start_at: '2019-01-01', department_id: 1, index: 6, menu_category_ids: [1])
Option.where(id: 8).first_or_create!(name: '赤ちゃん鍼', skill_id: 2, fee: 1000, start_at: '2019-01-01', department_id: 1, index: 7, menu_category_ids: [1])
Option.where(id: 9).first_or_create!(name: '置鍼', skill_id: 2, fee: 300, start_at: '2019-01-01', department_id: 1, index: 8, menu_category_ids: [1])

Store.where(id: 1).first_or_create!(
  store_type: 0,
  name: '女性専門の治療院オリーヴボディケア たまプラーザ店',
  address: '横浜市青葉区新石川3-15-16 メディカルモールたまプラーザ301',
  tel: '045-530-1688',
  mail: 'info@olivebodycare.jp',
  url: 'https://olivebodycare.healthcare/salon/tamaplaza',
  open_at: '10:00',
  close_at: '20:00',
  break_from: '13:00',
  break_to: '15:00'
)

Store.where(id: 2).first_or_create!(
  store_type: 0,
  name: 'Simpleste たまプラーザのエステ',
  address: '横浜市青葉区新石川3-15-16　メディカルモールたまプラーザ301',
  tel: '045-530-3966',
  mail: 'simpleste.olivejapan@gmail.com',
  url: 'https://simpleste.jp',
  open_at: '10:00',
  close_at: '20:00',
  break_from: '13:00',
  break_to: '15:00'
)

Menu.all.each do |menu|
  store_id = menu.id < 11 ? 1 : 2
  StoreMenu.where(store_id: store_id, menu_id: menu.id).first_or_create!
end

Option.all.each do |option|
  StoreOption.where(store_id: 1, option_id: option.id).first_or_create!
end
