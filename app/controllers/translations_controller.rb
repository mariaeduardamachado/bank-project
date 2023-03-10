class TranslationsController < ApplicationController
  before_action :set_translation, only: [:withdraw, :transfer, :deposit]
  def index
    @translations = Translation.all    
  end

  def show
    @translation = Translation.find(params[:id])
  end
  
  def withdraw
  end

  def transfer
  end

  def deposit
  end

  def create
    @translation = Translations::TranslationsService.run(translations_params, current_user)
    if @translation == false
      redirect_to action: :index
    else
      redirect_to action: :index
    end
  end

  private

  def translations_params
    params.require(:translation).permit(:translation_value, :translation_type, :user_id, :password_translation, :balance, :transferred_user)
  end

  def set_translation
    @translation = Translation.new
  end
end
