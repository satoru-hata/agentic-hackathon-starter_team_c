class WorkLocation < ApplicationRecord
  belongs_to :employee_profile

  STATUSES = %w[office remote out_of_office].freeze

  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :date, presence: true
  validates :employee_profile_id, uniqueness: { scope: :date, message: "can only have one work location per day" }

  scope :today, -> { where(date: Date.today) }
  scope :for_date, ->(date) { where(date: date) }
end
