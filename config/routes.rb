Rails.application.routes.draw do

  #生成したコントローラーがどこに存在するかを記述, 不要なルーティングを削除
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }
  devise_for :user, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  #ゲスト側
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end


  root to: 'public/homes#top'
  get "public/about" => 'public/homes#about'

  #管理者側
  namespace :admin do
    #会員情報
    resources :users
    #投稿
    resources :posts do
      #コメント機能
      resources :post_comments, only: [:create, :destroy]
      #グループ機能
      resources :groups do
        resource :group_users, only: [:create, :destroy]
        delete "all_destroy" => 'groups#all_destroy'
      end
    end
    
    #検索
    get "search" => 'searches#search'
    get "search_tag"=>"posts#search_tag"
  end

  #会員側
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
      #グループ機能
      resources :groups do
        resource :group_users, only: [:create, :destroy]
        delete "all_destroy" => 'groups#all_destroy'
       resources :event_notices, only: [:new, :create]
       get "event_notices" => "event_notices#sent"
      end
    end

    #検索
    get "search" => 'searches#search'
    get "search_tag"=>"posts#search_tag"
  end










  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
