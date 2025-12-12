class WorkLocation < ApplicationRecord
  belongs_to :user_profile

  # Valid work location status values as defined in spec.md:
  # - office: Working at office
  # - remote: Remote work
  # - out_of_office: Out/Vacation
  STATUSES = %w[office remote out_of_office].freeze

  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :date, presence: true
  validates :user_profile_id, uniqueness: { scope: :date, message: "can only have one work location per day" }

  scope :today, -> { where(date: Date.today) }
  scope :for_date, ->(date) { where(date: date) }
end
