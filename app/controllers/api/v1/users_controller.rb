class Api::V1::UsersController < Api::V1::ApplicationController
  before_action :authorize_request, except: :create

  def me
    render_success(@current_user)
  end
end
