require 'rails_helper'

RSpec.describe 'Users', type: :system do
  subject(:user) { create(:user) }

  describe 'ログイン前' do
    context 'ログイン後画面に遷移しようとした場合' do
      it 'ログイン画面に誘導される' do
        visit users_path
        expect(current_path).to eq login_users_path
        expect(page).to have_content 'ログインが必要です'
      end
    end

    it 'トップページが表示される' do
      visit root_path
      expect(page).to have_content 'つぶやきで、世界はつながる'
      expect(page).to have_link 'TweetApp'
      expect(page).to have_link 'TweetAppとは'
      expect(page).to have_link '新規登録'
      expect(page).to have_link 'ログイン'
    end

    it '説明ページが表示される' do
      visit about_path
      expect(page).to have_content 'SNSサービスです。'
    end

    describe 'ユーザ新規登録' do
      before { visit new_user_path }

      it '新規登録ページが表示される' do
        expect(page).to have_content '新規ユーザー登録'
      end

      context '入力が正しい場合' do
        it 'ユーザ情報が新規登録されユーザ詳細画面に遷移する' do
          fill_in 'name', with: 'new_name'
          fill_in 'email', with: 'new_email@test.com'
          fill_in 'password', with: 'new_password'
          click_button '新規登録'

          new_user = User.order(created_at: :desc).first
          expect(current_path).to eq user_path(new_user)
          expect(page).to have_content 'ユーザー登録が完了しました'
        end
      end

      context '入力に誤りがある場合' do
        it 'エラーメッセージが表示されること' do
          expect(page).to have_field 'name', with: ''
          expect(page).to have_field 'email', with: ''
          expect(page).to have_field 'password', with: ''
          click_button '新規登録'

          expect(page).to have_content 'Nameを入力してください'
          expect(page).to have_content 'Emailを入力してください'
          expect(page).to have_content 'Password'
        end
      end
    end

    describe 'ログイン' do
      before { visit login_users_path }

      it 'ログインページが表示される' do
        expect(page).to have_content 'ログイン'
        expect(page).to have_button 'ログイン'
      end

      context '正しいユーザ情報を入力した場合' do
        it 'ログインできること' do
          fill_in 'email', with: user.email
          fill_in 'password', with: user.password
          click_button 'ログイン'
  
          expect(page).to have_content 'ログインしました'
        end
      end

      context '誤ったユーザ情報を入力した場合' do
        it 'ログインできないこと' do
          expect(page).to have_field 'email', with: ''
          expect(page).to have_field 'password', with: ''
          click_button 'ログイン'
  
          expect(page).to have_content 'メールアドレスまたはパスワードが間違っています'
        end
      end
    end
  end

  describe 'ログイン後' do
    before { login(user) }

    describe 'ユーザ一覧' do
      it 'ユーザ一リストが表示されること' do
        visit users_path
        expect(page).to have_content 'ユーザーリスト'
        users = User.all
        users.each do |u|
          expect(page).to have_link u.name
        end
      end
    end

    describe 'ユーザ編集' do
      before { visit edit_user_path(user) }

      context '入力が正しい場合' do
        it 'ユーザ情報の更新ができること' do
          expect(page).to have_field 'name', with: user.name
          expect(page).to have_field 'email', with: user.email
          fill_in 'name', with: 'fixed_name'
          attach_file 'image', "public/user_images/10.jpg"
          fill_in 'email', with: 'fixed_email@test.com'
          click_button '保存'
  
          expect(current_path).to eq user_path(user)
          expect(page).to have_content 'ユーザー情報を編集しました'
          expect(page).to have_content 'fixed_name'
          expect(page).to have_content 'fixed_email@test.com'
        end
      end

      context '入力に誤りがある場合' do
        it 'エラーメッセージが表示されること' do
          fill_in 'name', with: ''
          fill_in 'email', with: ''
          click_button '保存'
  
          expect(page).to have_content 'Nameを入力してください'
          expect(page).to have_content 'Emailを入力してください'
        end
      end
    end
  end
end