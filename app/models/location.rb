class Location < ApplicationRecord
  belongs_to :locationable, polymorphic: true

  validates :latitude, presence: true
  validates :longitude, presence: true
  validate :check_booking_uniqueness, if: :booking?

  enum status: { car: 0, pickup: 1, dropoff: 2 }

  private

  def booking?
    locationable_type == 'Booking'
  end

  def check_booking_uniqueness
    if locationable.locations.where(status: status).count >= 1
      errors.add(:status, "cant have more than one booking location with one status")
    end
  end
end
