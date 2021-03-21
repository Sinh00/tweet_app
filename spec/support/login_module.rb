module LoginModule
  def login(user)
    visit login_users_path
    fill_in 'email', with: user.email
    fill_in 'password', with: user.password
    click_button 'ログイン'
  end
end