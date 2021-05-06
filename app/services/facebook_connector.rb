class FacebookConnector
  def self.get_profile(access_token)
    oauth = Koala::Facebook::OAuth.new
    new_access_info = oauth.exchange_access_token_info(access_token)
    new_access_token = new_access_info['access_token']
    new_access_expires_at = DateTime.now + new_access_info['expires_in'].to_i.seconds
    graph = Koala::Facebook::API.new(new_access_token)
    profile = graph.get_object('me', fields: 'id, name, email, picture')

    return profile
  end
end