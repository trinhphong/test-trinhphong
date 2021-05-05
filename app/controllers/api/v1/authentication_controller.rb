class Api::V1::AuthenticationController < Api::V1::ApplicationController
  before_action :authorize_request, except: :facebook

  def facebook
    user = User.find_by(email: permitted_params[:email], uid: permitted_params[:uid])

    if !user
      user = User.create(permitted_params)
      user.update(encrypted_password: SecureRandom.urlsafe_base64)
    end

    token = JsonWebToken.encode(user_id: user.id)
    render_success(token: "Bearer #{token}")
  end

  private

  def permitted_params
    standardized_params.permit(:email, :uid, :provider, :avatar_url, :full_name)
  end
end
