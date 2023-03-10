require "active_support/core_ext/object/try"
require "active_support/core_ext/date_time/conversions"

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
    end

    def run
      translation
    end

    private

    def translation
      password = @params[:password_translation]
      password_user = @current_user.password_card

      withdraw_type = ("prompt Saque" || "Saque")
      deposit_type = ("prompt Deposito" || "Deposito")

      if @transfer_type.present? &&  @transfer_value.present? &&  password.present?  && password == password_user
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
      value = current_user.balance.to_f + @transfer_value.to_f
     
      translation = Translation.new(@params)
      translation.save
      status = translation.update_columns(balance: @transfer_value, translation_type: deposit)
      current_user.update_columns(balance: value)
      @translation = status == true ? @translation : false
    end

    def withdraw
      withdraw = "Saque"
      value = current_user.balance.to_f - @transfer_value.to_f
      balance = current_user.balance >= @transfer_value

      if balance
        translation = Translation.new(@params)
        translation.save
        status = translation.update_columns(balance: value, translation_type: withdraw)
        current_user.update_columns(balance: value)
        translation = status == true ? @translation : false
      else
        @translation = false
      end

    end

    def transfer
      transfer = "Transferência"
      balance = current_user.balance >= @transfer_value
      value = current_user.balance.to_f - @transfer_value.to_f
      transfer_user = @params[:transferred_user].to_i
      midweek = 5
      other_schedules = 7

      ##Validação do horário e dia da semana##
      t = Time.now
      time = t.strftime("%H:%M") >= "09:00" || t.strftime("%H:%M") <= "18:00"
      date = t.strftime("%a") == "Sat" || t.strftime("%a") == "Sun"
      
      if balance && (time || date)
        translation = Translation.new(@params)
        translation.save
        value = value - other_schedules
        transfer_value =  @transfer_value.to_f 
        status = translation.update_columns(balance: value, translation_type: transfer, translation_value: transfer_value)
        user = User.find(transfer_user)
        transfer_value = user.balance.to_f + transfer_value
        user.update_columns(balance:transfer_value)
        translation = status == true ? @translation : false
        current_user.update_columns(balance: value)
       
      elsif balance
        translation = Translation.new(@params)
        @translation.save
        value = value - midweek
        transfer_value =  @transfer_value.to_f 
        status = translation.update_columns(balance: value, translation_type: transfer, translation_value: transfer_value)
        user = User.find(transfer_user)
        transfer_value = user.balance.to_f + transfer_value
        user.update_columns(balance:transfer_value)
        translation = status == true ? @translation : false
        current_user.update_columns(balance: value)
        
      elsif balance && @transfer_value.to_f >= 1000
        translation = Translation.new(@params)
        value = value - 10
        transfer_value =  @transfer_value.to_f 
        status = translation.update_columns(balance: value, translation_type: transfer, translation_value: transfer_value)
        user = User.find(transfer_user)
        transfer_value = user.balance.to_f + transfer_value
        user.update_columns(balance:transfer_value)
        translation = status == true ? @translation : false
        current_user.update_columns(balance: value)
        
      else
        translation = false
      end
    end

  end
end
