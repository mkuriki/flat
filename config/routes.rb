Rails.application.routes.draw do
  #生成したコントローラーがどこに存在するかを記述,不要なルーティングを削除
  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  #管理者側
  namespace :admins do
    #会員情報
    resources :users
  end
  
  #ユーザー側
  namespace :public do
    #トップ
    root to: 'homes#top'
    get "home/about" => 'homes#about'
    #ログインユーザー情報
    resources :users , only: [:show, :edit, :update]
    get "users/:id/quit" => 'customers#quit'
    patch "users/:id/quit" => 'customers#withdraw'
    #投稿
    resources :posts
    #いいね機能
    resources :favorites
    #コメント機能
    resources :post_comments
    #グループ機能
    resources :groups
  end
  
  #検索
  get "search" => "searches#search"
  
  
  
  
  
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
