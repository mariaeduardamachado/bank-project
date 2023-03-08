class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, :phone, :cpf, :rg, :road, :neighborhood, :number, :complement,
            :cep, :income, :patrimony, :number, presence: true

  has_one_attached :avatar
  has_one :translation
end
