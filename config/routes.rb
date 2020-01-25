Rails.application.routes.draw do
  # ホーム
  root 'home#top'
  get "about" => "home#about"

  resources :users, :posts
end
