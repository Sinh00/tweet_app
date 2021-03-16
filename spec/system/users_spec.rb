require 'rails_helper'

RSpec.describe 'Users', type: :system do
  subject(:user) { create(:user) }

  describe 'ログイン前' do
    
  end

  describe 'ログイン後' do
    
  end

  it 'ログイン画面が表示される' do
    # User編集画面を開く
    # visit login_users_path
    visit root_path
    expect(page).to have_content 'つぶやき'
    # expect(page).to have_content 'つぶやさ'

    # Nameに"いとう"が入力されていることを検証する
    # expect(page).to have_field '名前', with: 'いとう'

    # # 郵便番号を入力
    # fill_in '郵便番号', with: '158-0083'
    # # 住所が自動入力されたことを検証する
    # expect(page).to have_field '住所', with: '東京都世田谷区奥沢'

    # # 更新実行
    # click_button 'Update User'

    # # 正しく更新されていること（＝画面の表示が正しいこと）を検証する
    # expect(page).to have_content 'User was successfully updated.'
    # expect(page).to have_content 'いとう'
    # expect(page).to have_content '158-0083'
    # expect(page).to have_content '東京都世田谷区奥沢'
  end
end