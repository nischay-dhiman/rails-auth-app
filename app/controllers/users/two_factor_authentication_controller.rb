class Users::TwoFactorAuthenticationController < ApplicationController
  before_action :authenticate_user!

  def show_qr
    @qr = RQRCode::QRCode.new(current_user.provisioning_uri(nil, issuer: "YourAppName"))
    @qr_svg = @qr.as_svg(module_size: 4)
  end
end