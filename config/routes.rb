Rails.application.routes.draw do
  # トップページの設定
  root "font_designs#index"

  # ユーザー登録用
  resources :users, only: [:new, :create]

  # ログイン/ログアウト用
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end