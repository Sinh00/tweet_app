Rails.application.routes.draw do
  # ホーム
  get "/" => "home#top"
  get "about" => "home#about"

  # 投稿
  get "posts" => "posts#index"
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts/create"
end
