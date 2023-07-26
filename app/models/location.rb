class Location < ApplicationRecord
  belongs_to :car

  validates :latitude, presence: true
  validates :longitude, presence: true
end
