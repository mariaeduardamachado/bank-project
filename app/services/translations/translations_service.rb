module Translations
  class TranslationsService
    attr_reader :translations_params, :current_user

    def self.run(translations_params, current_user = User.find(User::DEFAULT_ID))
      new(translations_params, current_user).run
    end

    def initialize(translations_params,current_user)
      @params = translations_params
      @current_user = current_user
      @transfer_type = @params[:translation_type]
      @transfer_value = @params[:translation_value] 
      @password = @params[:password_translation]
      @password_user = @current_user.password_card
      @translation = Translation.new(@params)
     
    end

    def run
      translation
    end

    private

    def translation
      if @transfer_type.present? &&  @transfer_value.present? &&  @password.present?  && @password == @password_user
        if @transfer_type == ("prompt Deposito" || "Deposito")
          deposit
        elsif @transfer_type == ("prompt Saque" || "Saque")
          withdraw
        else 
          transfer
        end
      else
        @translation = false
      end
  
    end

    def deposit
      deposit = "Deposito"
      @translation.save
      status = @translation.update_columns(balance: @transfer_value, translation_type: deposit, user_id: current_user.id)
      @translation = status == true ? @translation : false
    end

    def withdraw
      deposit = "Saque"
      @translation.save
      status = @translation.update_columns(balance: @transfer_value, translation_type: deposit, user_id: current_user.id)
      @translation = status == true ? @translation : false
    end

    def transfer
      deposit = "Transferência"
      @translation.save
      status = @translation.update_columns(balance: @transfer_value, translation_type: deposit, user_id: current_user.id)
      @translation = status == true ? @translation : false
    end

  end
end
@params