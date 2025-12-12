class User < ApplicationRecord
  has_secure_password

  has_one :employee_profile, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { password.present? }
end
