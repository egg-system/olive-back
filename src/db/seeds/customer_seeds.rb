Customer.where(id: 1).first_or_create(costomer_id:1
, first_name:'高橋'
, last_name:'顧客1'
, first_kana:'高橋'
, last_kana:'こきゃく１'
, tel:'090-0000-0000'
, pc_mail:'tt.wing001@gmail.com'
, sp_mail:'tt.wing003@gmail.com'
, can_receive_mail:true
, birthday:'1985-1-1'
, zip_code:'160-0022'
, prefecture:'東京都'
, city:'新宿区新宿１−１−１　なんとかビル１階'
, address:'東京都	新宿区新宿１−１−１　なんとかビル１階'
, has_membership:true
, comment1:'コメント欄１です'
, comment2:'コメント欄２です'
, fitsrt_visit_store_id:1
, last_visit_store_id:2
, first_visit_at:'2019-01-01'
, last_visit_at:'2019-02-01'
, customer_info_json{
    medical_record_no:1,
    occupation:3,
    personality:2,
    with_child_status_id:2,
    baby_after_born:10,
    visit_history:5,
    introduction:'なし',
    web_search:'たまプラーザ　マッサージ',
    nearest_station:8,
    size:3,
    patient_card:1
})