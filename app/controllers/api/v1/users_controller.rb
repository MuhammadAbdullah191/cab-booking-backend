class Api::V1::UsersController < ApplicationController

	def index
    @users = User.all
    render json: { users: @users }, status: :ok
  end

	def create
    phone = user_params[:phone]
    user_otp = user_params[:otp]
    user = User.find_by_phone(phone)

    unless user
      render json: { message: 'User not found' }, status: :not_found
      return
    end
    if user.otp.present? && user.otp_valid?(user_otp)
      login_user(user)
    else
      render json: { message: 'Invalid phone number or OTP' }, status: :unauthorized
    end
  end

	private

	def login_user(user)
		new_token = generate_user_token(user)
		user.otp.destroy

		render json: {
			message: 'Successfully Logged In',
			token: new_token,
			user: UserSerializer.new(user)
		}, status: :ok
  end

	def generate_user_token(user)
    expiration_time = Time.now + 1.day
    payload = { user: user, exp: expiration_time.to_i }
    jwt_token = JWT.encode(payload, ENV['SECRET_KEY_BASE'])
    jwt_token
  end

	def user_params
    params.permit(:id, :phone, :username, :avatar, :query, :otp)
  end

end
