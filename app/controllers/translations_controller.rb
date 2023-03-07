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

  def create
    @translation = Translation.find(params[:id])

    if @translation.update(translations_params)
      redirect_to@translation
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    @translation = Translation.find(params[:id])
  end

  private

  def translations_params
    params.requeri(:translations).permit(:translation_value, :translation_type, :user_id)
  end

  def deposit
    @translation = Translation.new
  end

end