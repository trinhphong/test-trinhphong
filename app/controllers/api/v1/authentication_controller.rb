class Api::V1::AuthenticationController < Api::V1::ApplicationController
  before_action :authorize_request, except: :facebook

  def facebook
    oauth = Koala::Facebook::OAuth.new
    new_access_info = oauth.exchange_access_token_info(permitted_token_params[:token])
    new_access_token = new_access_info["access_token"]
    new_access_expires_at = DateTime.now + new_access_info["expires_in"].to_i.seconds
    graph = Koala::Facebook::API.new(new_access_token)
    profile = graph.get_object('me', fields: 'id, name, email, picture')

    user = User.find_by(email: profile['email'], uid: profile['id'])

    if !user
      createData = map_facebook_profile_to_user(profile)
      user = User.create(createData)
      user.update(encrypted_password: SecureRandom.urlsafe_base64)
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
      full_name: profile['name']
    }
  end

  def permitted_token_params
    standardized_params.permit(:token)
  end
end
