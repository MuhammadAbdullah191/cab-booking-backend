class Car < ApplicationRecord
  belongs_to :user

  validate :user_must_be_a_driver
    
  private

  def user_must_be_a_driver
    errors.add(:user, "must be a driver") unless user&.type =='Driver'
  end
end
