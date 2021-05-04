class Api::V1::UsersController < Api::V1::ApplicationController
  before_action :set_account, only: :show

  def show
    render_success(@account)
  end

  private

  def set_account
    @account = User.find(1)
  end
end
