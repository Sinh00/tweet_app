require 'rails_helper'

RSpec.describe Post, type: :model do
  subject(:post) { create(:post) }

  describe 'バリデーションテスト' do
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_length_of(:content) }
  end

  describe 'アソシエーションテスト' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:liked_users) }
  end

  describe 'クラスメソッドテスト' do
  end

  describe 'インスタンスメソッドテスト' do
    before do
      user1 = create(:user)
      user2 = create(:user)
      Like.create(user: user1, post: post)
      Like.create(user: user2, post: post)
    end
    it 'likes_countメソッドがいいね数を返すこと' do
      expect(post.likes_count).to eq 2
    end
  end
end