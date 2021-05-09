Given(/^Stub Facebook Request$/) do
  stub_request(:post, "https://graph.facebook.com/oauth/access_token").to_return(status: 200, body: "", headers: {})
  stub_request(:get, "http://facebook.com/api/v1/get_token").to_return(status: 200, body: '', headers: {})
  stub_request(:get, "http://graph.facebook.com/me?fields=id,%20name,%20email,%20picture").to_return(status: 200, body: {
    email: 'test_kfscezi_user@tfbnw.net',
    id: '123',
    name: 'Test User',
    picture: {
      data: {
        url: 'http://test.url'
      }
    }
  }.to_json, headers: {})
end

When(/^FE send a request no token$/) do
  @response = post '/api/v1/auth/facebook'
end

Then(/^API response an unathorized status$/) do
  expect(@response.status).to eq(401)
end

When(/^FE send a request an authorization token$/) do
  @response = post '/api/v1/auth/facebook', { token: 'sample_token' }
end

Then(/^API response an success status$/) do
  expect(@response.status).to eq(200)
end

Then(/^API return a jwt token$/) do
  expect(@response.body).to include('token')
end
