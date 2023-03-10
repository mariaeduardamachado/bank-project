class RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:phone, :name, :avatar, :cpf, :rg, :road, :neighborhood, 
                                      :number, :complement, :cep, :income, :patrimony,  :sex,
                                      :password_card,:city, :state])
  end
end