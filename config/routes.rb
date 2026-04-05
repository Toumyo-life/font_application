Rails.application.routes.draw do
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  # トップページの設定
  root "font_designs#index"

  # ログイン/ログアウト用(次のステップで必要)
  get "login", to: "sessions#new"
end
