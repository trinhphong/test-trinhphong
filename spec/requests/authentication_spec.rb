require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  AUTH_ENDPOINT =  '/api/v1'
  ME_ENPOINT = AUTH_ENDPOINT + '/auth/facebook'

  describe 'POST /auth/facebook' do
    let!(:fb_response) do
      {
        email: 'test@yopmail.com',
        id: '123',
        name: 'Full Name',
        picture: {
          data: {
            url: 'http://test.url'
          }
        }
      }
    end

    before do
      stub_request(:post, 'https://graph.facebook.com/oauth/access_token').to_return(status: 200, body: '', headers: {})
      stub_request(:get, 'http://facebook.com/api/v1/get_token').to_return(status: 200, body: '', headers: {})
      stub_request(:get, 'http://graph.facebook.com/me?fields=id,%20name,%20email,%20picture').to_return(status: 200, body: fb_response.to_json, headers: {})
    end

    context 'provide a valid token' do
      context 'with a new user' do
        it 'connect with facebook successfully' do
          post '/api/v1/auth/facebook', params: { token: 'sample_token' }
          expect(response).to have_http_status(:success)
        end

        it 'create a new user' do
          expect {
            post '/api/v1/auth/facebook', params: { token: 'sample_token' }
          }.to change { User.count }.by(1)
        end

        it 'return a jwt token' do
          post '/api/v1/auth/facebook', params: { token: 'sample_token' }
          expect(response.body).to include('token')
        end
      end

      context 'with an registered user' do
        let(:user) { create(:user) }

        it 'return a jwt token' do
          post '/api/v1/auth/facebook', params: { token: 'sample_token' }
          expect(response.body).to include('token')
        end
      end
    end

    context 'not provide any token' do
      it 'response with an unauthorized status' do
        post '/api/v1/auth/facebook', params: {}
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
