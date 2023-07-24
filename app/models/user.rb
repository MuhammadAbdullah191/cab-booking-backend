class User < ApplicationRecord
  validates :phone,
  format: { with: /\A((\+92)?(0092)?(92)?(0)?)(3)([0-9]{9})\z/,
            message: 'number is invalid. Please enter again' }
  validates :phone, uniqueness: true, presence: true
  validates :username, presence: true, length: { minimum: 5, maximum: 25 }, on: :update

end
