Rails.application.routes.draw do
devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about'
  #フォロー機能
  resources :users do
    resource :relationships, only: [:create, :destroy]#今回は作成と解除のみ
    get :following, on: :member#フォローしてる人の表示
    get :followers, on: :member#フォローしてる人の表示
  end

  resources :books do
  resource :favorites, only: [:create, :destroy]#いいね
  resources :book_comments, only: [:create, :destroy]#コメント
end
end