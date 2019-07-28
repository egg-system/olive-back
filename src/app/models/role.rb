# frozen_string_literal: true

class Role < ApplicationRecord
  has_many :staffs

  ADMIN = 1
  HEAD = 2
  MANAGER = 3
  STAFF = 4

  def admin?
    id === ADMIN
  end

  def head?
    admin? || id === HEAD
  end

  def manager?
    head? || id === MANAGER
  end

  def staff?
    manager? || id === STAFF
  end
end
