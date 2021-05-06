class Api::V1::AuthenticationController < Api::V1::ApplicationController
  before_action :authorize_request, except: :facebook

  def facebook
    if !permitted_token_params[:token]
      return render_error('No token provided', status: :unauthorized)
    end

    profile = FacebookConnector.get_profile(permitted_token_params[:token])

    if !profile
      return render_error('Not found facebook user', status: :unauthorized)
    end

    user = User.find_by(email: profile['email'], uid: profile['id'])

    if !user
      createData = map_facebook_profile_to_user(profile)
      user = User.create(createData)
    end

    token = JsonWebToken.encode(user_id: user.id)
    render_success(token: "Bearer #{token}")
  end

  private

  def map_facebook_profile_to_user(profile)
    {
      uid: profile['id'],
      email: profile['email'],
      provider: 'facebook',
      avatar_url: profile['picture']['data']['url'],
      full_name: profile['name'],
      encrypted_password: SecureRandom.urlsafe_base64
    }
  end

  def permitted_token_params
    standardized_params.permit(:token)
  end
end
