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

      withdraw_type = ("prompt Saque" || "Saque")
      deposit_type = ("prompt Deposito" || "Deposito")
      
      if @transfer_type.present? &&  @transfer_value.present? &&  @password.present?  && @password == @password_user
        if @transfer_type == deposit_type
          deposit
        elsif @transfer_type == withdraw_type
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
      status = @translation.update_columns(balance: @transfer_value, translation_type: deposit)
      @translation = status == true ? @translation : false
    end

    def withdraw

      withdraw = "Saque"
      value = current_user.balance.to_f - @transfer_value.to_f

      if  @transfer_value <= current_user.balance 
        @translation.save
        status = @translation.update_columns(balance: value, translation_type: deposit)
        @translation = status == true ? @translation : false
      else
        @translation = false
      end

    end

    def transfer
      transfer = "Transferência"
      if  @transfer_value <= current_user.balance 
        @translation.save
        status = @translation.update_columns(balance: @value, translation_type: deposit)
        @translation = status == true ? @translation : false
      else
        @translation = false
      end

    end

  end
end
