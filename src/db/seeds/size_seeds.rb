# frozen_string_literal: true

Size.where(id: 1).first_or_create!(name: 'S')
Size.where(id: 2).first_or_create!(name: 'S〜M')
Size.where(id: 3).first_or_create!(name: 'M')
Size.where(id: 4).first_or_create!(name: 'M〜L')
Size.where(id: 5).first_or_create!(name: 'L')
Size.where(id: 6).first_or_create!(name: 'XL')
