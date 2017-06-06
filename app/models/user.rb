class User < ApplicationRecord
  # attr_accessor :email, :password, :password_confirmation, :first_name
  # attr_accessor :first_name, :last_name, :adress
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
