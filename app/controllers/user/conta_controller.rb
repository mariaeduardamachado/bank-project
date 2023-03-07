class User::ContaController < UserController
  before_action :set_user, only: [:edit, :update]

  def index
    @users = User.all
  end

  def edit
  end


  private 

  def form_params
    params.requeri(:user).permit()
  end

  def set_user
    @user = User.find(params[:id])
  end

end