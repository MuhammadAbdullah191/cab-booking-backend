class User < ApplicationRecord
	has_one :otp
	validates :phone,
	format: { with: /\A((\+92)?(0092)?(92)?(0)?)(3)([0-9]{9})\z/,
						message: 'number is invalid. Please enter again' }
	validates :phone, uniqueness: true
	validates :username, presence: true, length: { minimum: 5, maximum: 25 }, on: :update

	def otp_valid?(otp)
    otp.present? && otp == self.otp.code && self.otp.expiration_time > Time.now
  end
end
