class Location < ApplicationRecord
  belongs_to :user
  has_many :appointments
  scope :recent, -> { order(created_at: :desc) }
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def booked_dates
    appointments.pluck(:date).map { |date| date.strftime('%Y-%m-%d') }
  end
end
