class Translation < ApplicationRecord
  belongs_to :user

  validates :translation_value, :translation_type , presence: true
  
end
