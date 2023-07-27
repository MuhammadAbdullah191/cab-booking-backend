class Review < ApplicationRecord
  belongs_to :booking

  validates :feedback, presence: true
  validates :rating, presence: true
  validates :booking_id, uniqueness: true, uniqueness: { message: "Cant have more then one review" }
end
