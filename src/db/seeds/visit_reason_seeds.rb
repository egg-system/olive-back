# frozen_string_literal: true

VisitReason.where(id: 1).first_or_create!(name: '広告・チラシ')
VisitReason.where(id: 2).first_or_create!(name: '看板・通りがかり')
VisitReason.where(id: 3).first_or_create!(name: '雑誌')
VisitReason.where(id: 4).first_or_create!(name: '知人の紹介')
VisitReason.where(id: 5).first_or_create!(name: 'Web検索')
VisitReason.where(id: 6).first_or_create!(name: 'その他')
