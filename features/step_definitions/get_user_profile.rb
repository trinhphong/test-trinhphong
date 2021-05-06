Given(/^Create sample users$/) do
  @me = create(:user)
  create(:user)
end

When(/^FE send a request with a valid jwt token$/) do
  header 'Authorization', JsonWebToken.encode(user_id: @me.id)
  @response = get '/api/v1/users/me'
end

Then(/^API response an user data correctly$/) do
  expect(@response.status).to eq(200)

  resJson = JSON.parse(@response.body)
  dataJson = resJson['data']

  expect(dataJson['email']).to eq(@me.email)
  expect(dataJson['fullName']).to eq(@me.full_name)
  expect(dataJson['uid']).to eq(@me.uid)
end
