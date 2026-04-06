Rails.application.routes.draw do
  resources :font_designs
  # トップページの設定
  root "font_designs#index"

  # ユーザー登録用
  resources :users, only: [ :new, :create ]

  # ログイン/ログアウト用
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :font_designs, only: [:index, :new, :create, :show, :edit, :update, :destroy]do
    member do
      get :download
      get :download_file
    end
  end
end
