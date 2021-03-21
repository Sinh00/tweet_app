Rails.application.routes.draw do
  # ホーム
  root "home#top"
  get "about" => "home#about"

  resources :users do
    member do
      get :likes
    end
  	collection do
  		get :login, to: "users#login_form"
  		post :login
  		delete :logout
  	end
  end

  resources :posts

  resources :likes, only: [:create, :destroy]
end
