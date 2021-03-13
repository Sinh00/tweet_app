require "validator/email_validator"

class User < ApplicationRecord
	has_secure_password

	validates :name, presence: true, length: { maximum: 20 }
	validates :email, presence: true, uniqueness: { case_sensitive: false }, email: { allow_blank: true }

	def posts
		Post.where(user_id: self.id).order(created_at: :desc)
	end
end
