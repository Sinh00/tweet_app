Rails.application.routes.draw do
  # ホーム
  get "/" => 'home#top'
  get "about" => 'home#about'

  # 投稿
  get "posts" => 'posts#index'
end
