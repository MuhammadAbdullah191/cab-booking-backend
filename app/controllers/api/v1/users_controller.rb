class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i(update destroy)
  skip_before_action :verify_token

  def index
    @users = User.all
    render json: { users: @users }, status: :ok
  end

  def create
    otp_service = OtpService.new(user_params[:phone])
    @response = otp_service.verify_otp(user_params[:otp])
    if @response[:status] == :ok
      login_user(@response[:user])
    else
      render json: { message: @response[:message] }, status: @response[:status]
    end
  end

  def update
    if @user.update(user_params)
      render json: { user: UserSerializer.new(@user), message: 'User updated successfully' }, status: :ok
    else
      render json: { message: @user.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = set_instance(user_params[:id], User, params[:type])
  end

  def login_user(user)
    new_token = generate_user_token(user)

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
    params.permit(:id, :otp, :phone, :username, :cnic, :license_number, :license_expiry)
  end

end
