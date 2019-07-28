# frozen_string_literal: true

Role.where(id: 1).first_or_create!(name: 'システム管理者権限')
Role.where(id: 2).first_or_create!(name: '本部権限')
Role.where(id: 3).first_or_create!(name: '店長権限')
Role.where(id: 4).first_or_create!(name: 'スタッフ権限')
