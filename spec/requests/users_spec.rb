require 'rails_helper'

RSpec.describe "Users", type: :request do

  def valid_session
    {}
  end

  def valid_attributes
    {
      email: 'test@yopmail.com',
      uid: '12345',
      provider: 'facebook',
      full_name: 'Full Name',
      avatar_url: 'testurl'
    }
  end

  describe "GET /me" do
    it "Unauthorized" do
      # user = User.create! valid_attributes
      get '/api/v1/users/me', {}
      expect(response.status).to eq(response.status)
    end
  end
end
