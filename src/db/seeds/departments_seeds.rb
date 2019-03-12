Department.where(id: 1).first_or_create(name:'整体・マッサージ')
Department.where(id: 2).first_or_create(name:'鍼灸')
Department.where(id: 3).first_or_create(name:'交通事故治療')
Department.where(id: 4).first_or_create(name:'不妊治療')
Department.where(id: 5).first_or_create(name:'エステ')
Department.where(id: 6).first_or_create(name:'ブライダルエステ')
Department.where(id: 7).first_or_create(name:'なし')

MenuCategory.where(id:1).first_or_create(name:'基本', department_id:1)
MenuCategory.where(id:2).first_or_create(name:'オプション', department_id:2)

Menu.where(id: 1).first_or_create(store_id:1, name:'初診・問診', description:'説明', fee:1000, service_minutes:0, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:2, memo:'補足事項')
Menu.where(id: 2).first_or_create(store_id:1, name:'初通常整体コース', description:'説明', fee:6000, service_minutes:60, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:1, memo:'補足事項')
Menu.where(id: 3).first_or_create(store_id:1, name:'整体スペシャルパックコース', description:'説明', fee:25000, service_minutes:120, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:1, memo:'補足事項')
Menu.where(id: 4).first_or_create(store_id:1, name:'足つぼ', description:'説明', fee:2000, service_minutes:0, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:2, memo:'補足事項')
Menu.where(id: 5).first_or_create(store_id:1, name:'小顔矯正', description:'説明', fee:4000, service_minutes:0, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:2, memo:'補足事項')
Menu.where(id: 6).first_or_create(store_id:1, name:'骨盤矯正', description:'説明', fee:6000, service_minutes:60, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:1, memo:'補足事項')
Menu.where(id: 7).first_or_create(store_id:1, name:'マッサージ', description:'説明', fee:6000, service_minutes:60, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:1, memo:'補足事項')
Menu.where(id: 8).first_or_create(store_id:1, name:'通常鍼灸（マッサージ有）', description:'説明', fee:6000, service_minutes:60, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:1, memo:'補足事項')
Menu.where(id: 9).first_or_create(store_id:1, name:'特別鍼灸（マッサージ無）', description:'説明', fee:6000, service_minutes:60, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:1, memo:'補足事項')
Menu.where(id: 10).first_or_create(store_id:1, name:'本治療', description:'説明', fee:2000, service_minutes:0, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:2, memo:'補足事項')
Menu.where(id: 11).first_or_create(store_id:1, name:'耳つぼ', description:'説明', fee:2000, service_minutes:0, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:2, memo:'補足事項')
Menu.where(id: 12).first_or_create(store_id:1, name:'耳つぼジュエリー', description:'説明', fee:500, service_minutes:0, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:2, memo:'補足事項')
Menu.where(id: 13).first_or_create(store_id:1, name:'赤ちゃん鍼', description:'説明', fee:1000, service_minutes:0, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:2, memo:'補足事項')
Menu.where(id: 14).first_or_create(store_id:1, name:'置鍼', description:'説明', fee:300, service_minutes:0, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:2, memo:'補足事項')
Menu.where(id: 15).first_or_create(store_id:1, name:'交通事故治療', description:'説明', fee:0, service_minutes:60, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:1, memo:'補足事項')
Menu.where(id: 16).first_or_create(store_id:1, name:'不妊治療（整体）', description:'説明', fee:6000, service_minutes:60, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:1, memo:'補足事項')
Menu.where(id: 17).first_or_create(store_id:1, name:'不妊治療（鍼灸）', description:'説明', fee:6000, service_minutes:60, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:1, memo:'補足事項')
Menu.where(id: 18).first_or_create(store_id:1, name:'初回カウンセリング', description:'説明', fee:1000, service_minutes:0, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:2, memo:'補足事項')
Menu.where(id: 19).first_or_create(store_id:1, name:'上半身メインコース', description:'説明', fee:6000, service_minutes:60, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:1, memo:'補足事項')
Menu.where(id: 20).first_or_create(store_id:1, name:'下半身メインコース', description:'説明', fee:6000, service_minutes:60, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:1, memo:'補足事項')
Menu.where(id: 21).first_or_create(store_id:1, name:'全身コース', description:'説明', fee:6000, service_minutes:60, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:1, memo:'補足事項')
Menu.where(id: 22).first_or_create(store_id:1, name:'フェイシャルメインコース', description:'説明', fee:6000, service_minutes:60, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:1, memo:'補足事項')
Menu.where(id: 23).first_or_create(store_id:1, name:'ダブルメインコース', description:'説明', fee:12000, service_minutes:60, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:1, memo:'補足事項')
Menu.where(id: 24).first_or_create(store_id:1, name:'シンプルプラン', description:'説明', fee:30000, service_minutes:60, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:1, memo:'補足事項')
Menu.where(id: 25).first_or_create(store_id:1, name:'エレガントプラン', description:'説明', fee:60000, service_minutes:60, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:1, memo:'補足事項')
Menu.where(id: 26).first_or_create(store_id:1, name:'デラックスプラン', description:'説明', fee:90000, service_minutes:60, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:1, memo:'補足事項')
Menu.where(id: 27).first_or_create(store_id:1, name:'ラグジュアリープラン', description:'説明', fee:126000, service_minutes:60, service_start_date:'2018-01-01', service_end_date:'9999-12-31', menu_category_id:1, memo:'補足事項')