Rails.application.routes.draw do
  
  #生成したコントローラーがどこに存在するかを記述, 不要なルーティングを削除
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }
  devise_for :user, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  

  #管理者側
  namespace :admin do
    #会員情報
    resources :users
    #投稿
    resources :posts do
    #コメント機能
    resources :post_comments, only: [:create, :destroy]
    end
     #グループ機能
    resources :groups do
      resource :group_users, only: [:create, :destroy]
    end
    
  end

  #ユーザー側
  namespace :public do
    #トップ
    root to: 'homes#top'
    #ログインユーザー情報
    resources :users , only: [:show, :edit, :update]
    get "users/:id/show_withdraw" => 'users#show_withdraw'
    patch "users/:id/show_withdraw" => 'users#withdraw'
    #投稿
    resources :posts do
      #いいね機能
      resource :favorites, only: [:create, :destroy]
      #コメント機能
      resources :post_comments, only: [:create, :destroy]
    end
    #グループ機能
    resources :groups do
      resource :group_users, only: [:create, :destroy]
    end
    #検索
    get "search" => 'searches#search'
  end

  
  get "home/about" => 'homes#about'








  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
