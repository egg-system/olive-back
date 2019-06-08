class Role < ApplicationRecord
  has_many :staffs

  ADMIN = 1
  HEAD = 2
  MANAGER = 3
  STAFF = 4

  def admin?
    return self.id === ADMIN
  end

  def head?
    return self.admin? || self.id === HEAD
  end

  def manager?
    return self.head? || self.id === MANAGER
  end

  def staff?
    return self.manager? || self.id === STAFF
  end
end
