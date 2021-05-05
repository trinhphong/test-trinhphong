class Api::V1::UsersController < Api::V1::ApplicationController
  before_action :authorize_request, except: :create

  def me
    render_success(user)
  end

  private

  def user
    @user ||= User.find(@current_user.id)
  end
end
