class UserController < ApplicationController
  before_action :authenticate_user

  def index
    @user = User.find (current_user.id)
    if @user.balance.present? == false
      @user.update_columns(balance:"0.00")
    end
  end

  def authenticate_user
    redirect_to new_user_session_path unless current_user
  end

  private

  def user_params
    params.require(:user).permit()
  end
end
