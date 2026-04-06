Rails.application.routes.draw do
  get "users/new"
  get "users/create"
  # ログイン/ログアウト用(次のステップで必要)
  get 'login', to: "sessions#new"
  post 'login', to: "sessions#create"
  delete 'logout', to: "sessions#destroy"
  # トップページの設定
  root "font_designs#index"

  # ユーザー登録用
  resources :users, only: [:new, :create]

  # ログイン/ログアウト用(次のステップで必要)
  get "login", to: "sessions#new"
end
