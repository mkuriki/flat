Rails.application.routes.draw do
  
  #生成したコントローラーがどこに存在するかを記述, 不要なルーティングを削除
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }
  devise_for :user, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  #トップ
  root to: 'homes#top'
  #管理者側
  namespace :admin do
    #会員情報
    resources :users
  end

  #ユーザー側
  namespace :public do
    #ログインユーザー情報
    resources :users , only: [:show, :edit, :update]
    get "users/:id/show_withdraw" => 'users#show_withdraw'
    patch "users/:id/show_withdraw" => 'users#withdraw'
    #投稿
    resources :posts do
      #いいね機能
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    #コメント機能
    #グループ機能
    resources :groups
    get "/groups" => 'groups#join'
  end

  
  get "home/about" => 'homes#about'
  #検索
  get "search" => 'searches#search'







  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
