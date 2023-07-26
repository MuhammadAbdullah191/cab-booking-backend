class Booking < ApplicationRecord
  has_many :locations, as: :locationable, dependent: :destroy

  belongs_to :user
  belongs_to :car
end
