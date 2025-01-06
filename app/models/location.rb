class Location < ApplicationRecord
  belongs_to :user
  scope :recent, -> { order(created_at: :desc) }
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
