class TranslationsController < ApplicationController
  def index
    @translations = Translation.all    
  end

  def show
    @translation = Translation.find(params[:id])
  end

  def new
    @translation = Translation.new
  end

  def deposit
    @translation = Translation.new

  end

  def create
    @translation = Translations::TranslationsService.run(translations_params, current_user)

    if @translation.update(translations_params)
      redirect_to @translation
    else
      render :deposit, status: :unprocessable_entity
    end
  end

  def edit
    @translation = Translation.find(params[:id])
  end

  private

  def translations_params
    params.require(:translation).permit(:translation_value, :translation_type, :user_id, :password_translation)
  end



end