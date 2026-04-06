Rails.application.routes.draw do
  resources :font_designs
  get 'static_pages/terms'
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
resources :tags

# プロフィール関連（単数リソース）
resource :profile, only: %i[show edit update] do
  # アバター画像の削除用
  delete :destroy_avatar, on: :member
end
# アップロードした画像一覧用
resources :font_designs, only: %i[index show edit update destroy]
end
