class Post < ApplicationRecord
  ##### アソシエーション ##########
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  ##### バリデーション ##########
	validates :content, { presence: true, length: { maximum: 140 } }

  ##### インスタンスメソッド ##########
  def likes_count
  	self.likes.count
  end
end
