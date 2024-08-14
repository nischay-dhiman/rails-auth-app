class User < ApplicationRecord
  devise :two_factor_authenticatable, otp_secret_encryption_key: ENV['OTP_SECRET_KEY']
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable,
         :recoverable, :rememberable, :validatable


  def valid_otp?(otp_attempt)
    return true unless otp_enabled?
    valid_otp = self.authenticate_otp(otp_attempt, drift: 60)
    valid_otp
  end


  def otp_enabled?
    self.otp_secret.present?
  end
  
  def provisioning_uri(account = nil, issuer: 'YourAppName')
    account ||= email
    otp_provisioning_uri(account, issuer: issuer)
  end
end
