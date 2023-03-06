class User::ContaController < UserController
  
  def index
    @users = User.all
  end

end