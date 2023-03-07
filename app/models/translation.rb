class Translation < ApplicationRecord
  has_many :user, foreign_key: :user_id

  validates :translation_value, :translation_type , presence: true
  
end
