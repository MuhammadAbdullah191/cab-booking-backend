class Booking < ApplicationRecord
  has_many :locations, as: :locationable, dependent: :destroy
  has_one :review

  belongs_to :user
  belongs_to :car
end
