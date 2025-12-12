class EmployeeProfile < ApplicationRecord
  belongs_to :user
  has_many :work_locations, dependent: :destroy

  validates :name, presence: true
  validates :department, presence: true
  validates :user_id, uniqueness: true
end
