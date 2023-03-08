class Translation < ApplicationRecord
  belongs_to :user

  validates :translation_value, :translation_type, :password_translation, presence: true
  
end
