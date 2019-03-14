# require 'faker'

# unless Store.exists?
#   3.times do
#     Store.create(
#       store_type: Faker::Number.between(0, 1),
#       name: Faker::Company.name
#     )
#   end
# end

# unless Staff.exists?
#   5.times do
#     Staff.create(
#       store_id: Store.order("RAND()").first().id,
#       first_name: Faker::Name.first_name,
#       last_name: Faker::Name.last_name
#     )
#   end
# end

# unless User.exists?
#   User.create(
#     role_id: Role.order("RAND()").first().id,
#     staff_id: Staff.order("RAND()").first().id,
#     email: 'email@olive.test',
#     password: 'password'
#   )
# end

Staff.where(id: 1).first_or_create(staff_id:1	first_name:'管理者', last_name:'花子', first_name_kana:'かんりしゃ', last_name_kana:'はなこp', staff_skill_id:2, store_id:1, role_id:1, employee_type:0, deleted_at:'')
Staff.where(id: 1).first_or_create(staff_id:1	first_name:'本部', last_name:'恵子', first_name_kana:'ほんぶ', last_name_kana:'けいこ', staff_skill_id:1, store_id:1, role_id:2, employee_type:0, deleted_at:'')
Staff.where(id: 1).first_or_create(staff_id:1	first_name:'店長', last_name:'愛子', first_name_kana:'たかはし', last_name_kana:'あいこ', staff_skill_id:2, store_id:1, role_id:3, employee_type:1, deleted_at:'')
Staff.where(id: 1).first_or_create(staff_id:1	first_name:'佐藤', last_name:'綾子', first_name_kana:'さとう', last_name_kana:'あやこ', staff_skill_id:1, store_id:1, role_id:4, employee_type:1, deleted_at:'')
Staff.where(id: 1).first_or_create(staff_id:1	first_name:'田中', last_name:'恵理子', first_name_kana:'たなか', last_name_kana:'えりこ', staff_skill_id:2, store_id:2, role_id:4, employee_type:2, deleted_at:'')
Staff.where(id: 1).first_or_create(staff_id:1	first_name:'鈴木', last_name:'恵理子', first_name_kana:'すずき', last_name_kana:'えりこ', staff_skill_id:2, store_id:3, role_id:4, employee_type:2, deleted_at:'')