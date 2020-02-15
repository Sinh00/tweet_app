class Post < ApplicationRecord

	validates :content, {presence: true, length: {maximum: 140}}
	validates :user_id, {presence: true}

	def user
    User.find_by(id: self.user_id)
  end

  def likes_count
  	Like.where(post_id: self.id).count
  end
end
