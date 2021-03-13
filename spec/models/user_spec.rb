require 'rails_helper'

# 他のgemを使わずにRSpecのデフォルトの機能でシンプルに記述
RSpec.describe User, type: :model do
  describe 'バリデーションテスト' do
    let(:user) { User.create(params) }
    let(:params) { { name: name, email: email, password: password } }

    context '正しい入力の場合' do
      let(:name) { 'tarou' }
      let(:email) { 'test@test.com' }
      let(:password) { 'password' }
      it { expect(user).to be_valid }
    end

    context '何も入力しなかった場合' do
      let(:name) { '' }
      let(:email) { '' }
      let(:password) { '' }
      it { expect(user).to be_invalid }
      it { expect(user.errors[:name].size).to eq 1 }
      it { expect(user.errors[:email].size).to eq 1 }
      it { expect(user.errors[:password].size).to eq 1 }
    end

    context '名前が文字数をオーバーしている場合' do
      let(:name) { 'aaaaabbbbbcccccddddde' }
      let(:email) { 'test@test.com' }
      let(:password) { 'password' }
      it { expect(user).to be_invalid }
      it { expect(user.errors[:name].size).to eq 1 }
    end

    context '同じメールアドレスが既に登録されている場合' do
      before do
        @user2 = User.create!(name: 'jirou', email: 'test@test.com', password: 'password')
      end
      let(:name) { 'tarou' }
      let(:email) { @user2.email }
      let(:password) { 'password' }
      it { expect(user).to be_invalid }
      it { expect(user.errors[:email].size).to eq 1 }
    end
    
    context 'メールアドレスのフォーマットが不正な場合' do
      let(:name) { 'tarou' }
      let(:email) { '@test.com' }
      let(:password) { 'password' }
      it { expect(user).to be_invalid }
      it { expect(user.errors[:email].size).to eq 1 }
    end
  end

  describe 'アソシエーションテスト' do
  end

  describe 'クラスメソッドテスト' do    
  end

  describe 'インスタンスメソッドテスト' do
    let!(:user) { User.create!(params) }
    let!(:params) { { name: 'tarou', email: 'test@test.com', password: 'password' } }
    let!(:post1) { Post.create!(user_id: user.id, content: '投稿1です') }
    let!(:post2) { Post.create!(user_id: user.id, content: '投稿2です') }

    context 'postsメソッドを呼び出す場合' do
      it '紐づく投稿データが参照できる' do
        # 件数が2件
        expect(user.posts.count).to eq 2
        # 取得順が作成日の降順
        expect(user.posts.first).to eq post2
      end
    end
  end
end