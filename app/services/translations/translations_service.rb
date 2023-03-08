module Translations
  class TranslationsService
    attr_reader :translations_params, :current_user

    def self.run(translations_params, current_user = User.find(User::DEFAULT_ID))
      new(translations_params, current_user).run
    end

    def initialize(translations_params,current_user)
      @params = translations_params
      @current_user = current_user
    end

    def run
      transfers_deposit
    end

    def transfers_deposit
      byebug
      @translation = Translation.new(translations_params)
    end
  end
end
