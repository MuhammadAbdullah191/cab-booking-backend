# app/services/otp_service.rb
class OtpService
  attr_reader :user, :phone

  def initialize(phone)
    @phone = phone
    @client = Twilio::REST::Client.new(ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN'])
  end

  def verify_otp(otp)
    begin
      verification_check = @client.verify.v2.services(ENV['SERVICE_SID']).verification_checks.create(to: '+923175098343', code:  otp)
      if verification_check.status == 'approved'
        return save_user
      else
        return {message: 'Invalid Otp, please try again', status: :unauthorized}
      end

    rescue StandardError => e
      Rails.logger.error("Error sending OTP: #{e.message}")
      return {message: e.message, status: :unauthorized}
    end
  end

  def send_otp
    begin
      verification = @client.verify.v2.services(ENV['SERVICE_SID']).verifications.create(to: '+923175098343', channel: 'sms')
      return true
    rescue StandardError => e
      Rails.logger.error("Error sending OTP: #{e.message}")
      return false
    end
  end
	
  private

  def save_user
    @user = User.find_or_initialize_by(phone: @phone)
    if @user.new_record?
      if !@user.save
        return {message: @user.errors.full_messages, status: :unauthorized}
      end
    end

    return {user: @user, message: 'Otp verified successfully', status: :ok}
  end
end
