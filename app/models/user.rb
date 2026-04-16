class User < ApplicationRecord
  has_secure_password

  enum :role, { student: 0, teacher: 1, admin: 2 }, validate: true

  normalizes :email, with: ->(e) { e.strip.downcase }

  validates :email, presence: true, uniqueness: { case_sensitive: false }
end
