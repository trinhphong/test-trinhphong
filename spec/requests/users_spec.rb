require 'rails_helper'

RSpec.describe "Users", type: :request do
  USERS_ENDPOINT =  '/api/v1/users'
  ME_ENPOINT = USERS_ENDPOINT + '/me'

  describe 'GET /me' do
    context 'did not log in' do
      it 'unauthorized with status 401' do
        get ME_ENPOINT, {}
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'logged in' do
      let(:current_user) { create(:user) }

      context 'valid params' do
        let(:valid_attributes) do
          {
            email: current_user.email,
            uid: current_user.uid,
            provider: current_user.provider,
            full_name: current_user.full_name,
            avatar_url: current_user.avatar_url
          }
        end

        before do
          get ME_ENPOINT, headers: authenticated_header(current_user.id)
        end

        it 'return success status' do
          expect(response).to have_http_status(:success)
        end

        it 'return correct the current user data' do
          resBody = JSON.parse(response.body)
          bodyData = resBody['data']
          expect(response.body).to include('data')
          expect(bodyData['_id']).to eq(current_user.id)
          expect(bodyData['email']).to eq(current_user.email)
          expect(bodyData['uid']).to eq(current_user.uid)
          expect(bodyData['provider']).to eq(current_user.provider)
          expect(bodyData['fullName']).to eq(current_user.full_name)
          expect(bodyData['avatarUrl']).to eq(current_user.avatar_url)
        end
      end

      context 'invalid params' do
        context 'token payload id is not found' do

          before do
            get ME_ENPOINT, headers: authenticated_header('invalid_id')
          end

          it 'proteced by authentication step and response unauthorized status' do
            expect(response).to have_http_status(:unauthorized)
          end
        end
      end
    end
  end
end

def authenticated_header(user_id)
  token = JsonWebToken.encode(user_id: user_id)
  { 'Authorization': token }
end