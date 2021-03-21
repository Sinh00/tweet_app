require 'rails_helper'

Rails.describe 'Posts', type: :system do
  subject(:user) { create(:user) }
  subject(:post) { create(:post, user: user) }
  before { login(user) }

  describe 'ツイートの一覧' do
    before do
      post2 = create(:post)
      post3 = create(:post)
      visit posts_path
    end

    it 'すべてのツイートが表示されている' do
      posts = Post.all
      posts.each do |p|
        expect(page).to have_link p.content
      end
    end
  end

  describe 'ツイートの詳細' do
    before { visit post_path(post) }
    it 'ツイートの情報が全て表示されている' do
      within '.posts-show-item' do
        expect(page).to have_content user.name
        expect(page).to have_selector "img[src$='/user_images/#{user.image_name}']"
        expect(page).to have_content post.content
        expect(page).to have_content post.created_at.strftime("%Y/%m/%d %H:%M")
        expect(page).to have_link '', href: likes_path(post_id: post.id)
        expect(page).to have_link '削除'
      end
    end
  end

  describe 'ツイートの投稿' do
    before { visit new_post_path }

    context '入力が正しい場合' do
      it 'ツイートが投稿される' do
        fill_in 'content', with: 'Hello'
        click_button '投稿'

        expect(current_path).to eq posts_path
        expect(page).to have_content '投稿を作成しました'
      end
    end

    context '入力に誤りがある場合' do
      it 'エラーが表示される' do
        tweet = 'Hello' * 30 # 150文字
        fill_in 'content', with: tweet
        click_button '投稿'

        expect(page).to have_content 'Contentは140文字以内で入力してください'
      end
    end
  end

  describe 'ツイートの削除' do
    it 'ツイートが正常に削除されツイート一覧画面に遷移する' do
      visit post_path(post)
      click_on '削除'

      expect(current_path).to eq posts_path
      expect(page).to have_content '投稿を削除しました'
    end
  end
end