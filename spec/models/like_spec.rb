require 'rails_helper'

RSpec.describe Like, type: :model do
  subject(:like) { create(:like) }

  describe '登録テスト' do
    it { is_expected.to be_valid }
  end

  describe 'アソシエーションテスト' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
  end
end