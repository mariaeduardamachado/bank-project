class User::ContaController < UserController
  before_action :set_user, only: [:edit, :update]

  def index
  end

  def edit
  end

  def show
  end

  private 

  def form_params
    params.requeri(:user).permit()
  end

  def set_user
    @user = User.find(params[:id])
  end

end