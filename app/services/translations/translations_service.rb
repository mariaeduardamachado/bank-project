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
     
      @translation = Translation.new(@params)
      @translation.save
      status = @translation.update_columns(balance: @transfer_value, translation_type: deposit)
      current_user.update_columns(balance: value)
      @translation = status == true ? @translation : false
    end

    def withdraw
      withdraw = "Saque"
      value = current_user.balance.to_f - @transfer_value.to_f

      if @transfer_value <= current_user.balance 
        @translation = Translation.new(@params)
        @translation.save
        status = @translation.update_columns(balance: value, translation_type: withdraw)
        current_user.update_columns(balance: value)
        @translation = status == true ? @translation : false
      else
        @translation = false
      end

    end

    def transfer
      transfer = "Transferência"
      midweek = 5
      other_schedules = 7
      t = Time.now
      time = t.strftime("%H:%M") >= "09:00" || t.strftime("%H:%M") <= "18:00"
      date = t.strftime("%a") == "Sat" || t.strftime("%a") == "Sun"
      balance = @transfer_value <= current_user.balance
      value = current_user.balance.to_f - @transfer_value.to_f
      transfer_user = @params[:transferred_user].to_i
      @translation = Translation.new(@params)


      hoje = Date.today 
      hoje.prev_occurring(:saturday)
      Time.now.to_s

      if balance && time && date 

        @translation.save
        value = value - other_schedules
        transfer_value =  @transfer_value.to_f + other_schedules

        status = @translation.update_columns(balance: value, translation_type: transfer, transfer_value: transfer_value)
        current_user.update_columns(balance: value)
        user = User.find(transfer_user).update_columns(balance:value)

        @translation = status == true ? @translation : false

      elsif balance
        
        @translation.save
        value = value - midweek
        transfer_value =  @transfer_value.to_f + midweek

        status = @translation.update_columns(balance: value, translation_type: transfer, transfer_value: transfer_value)
        current_user.update_columns(balance: value)
        user = User.find(transfer_user).update_columns(balance:value)

        @translation = status == true ? @translation : false

      elsif balance && @transfer_value.to_f >= 1000
        value = value - 10
        transfer_value =  @transfer_value.to_f + 10

        status = @translation.update_columns(balance: value, translation_type: transfer, transfer_value: transfer_value)
        current_user.update_columns(balance: value)
        user = User.find(transfer_user).update_columns(balance:value)

        @translation = status == true ? @translation : false

      else
        @translation = false
      end

    end
    

  end
end
