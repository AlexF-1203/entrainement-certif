class Appointment < ApplicationRecord
  belongs_to :user
  belongs_to :location

  validates :date, presence: true
  validate :date_cannot_be_in_the_past
  validates :date, uniqueness: { scope: :location_id, message: "is already booked for this location" }

  private

  def date_cannot_be_in_the_past
    if date.present? && date < Date.today
      errors.add(:date, "can't be in the past")
    end
  end
end
