class Api::V1::OtpsController < ApplicationController

	def create
    phone = otp_params[:phone]
    otp_service = OtpService.new(phone)
   
		@user = otp_service.send_otp
    if @user
      render json: { message: 'OTP sent successfully', user: @user }, status: :ok
    else
      render json: { message: 'Failed to send OTP' }, status: :unprocessable_entity
    end
  end

	private

	def otp_params
    params.permit(:id, :phone)
  end

end
