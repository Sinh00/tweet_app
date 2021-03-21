require "validator/email_validator"

class User < ApplicationRecord
	has_secure_password

	##### アソシエーション ##########
	has_many :posts, dependent: :destroy
	has_many :likes, dependent: :destroy

	##### バリデーション ##########
	validates :name, presence: true, length: { maximum: 20 }
	validates :email, presence: true, uniqueness: { case_sensitive: false }, email: { allow_blank: true }
end
