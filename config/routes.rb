Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"

  # root = 「/」のこと 特に指定がなければarticles#indexを表示する
  root to: 'articles#index'
  # get '/' => 'home#index'

  # タイムラインは1ユーザに対して1つしかないので、resourceにする
  resource :timeline, only: [ :show ] # %i(show)でも同義

  # URLをRailsが一括作成
  resources :articles do
    # 記事のURLの後ろにコメントのURLを続ける場合、入れ子構造にする（とRails側で自動でURLを一括作成してくれる）
    # resourcesとすると、URL上で複数あるcommentの中でidを指定する必要が出てくる（showやeditで/articles/:article_id/comments/:id が必要になる）
    resources :comments, only: [ :new, :create ]
    # 記事のURLの後ろにいいねのURLを続ける場合、入れ子構造にする（とRails側で自動でURLを一括作成してくれる）
    # resourcesとすると、URL上で複数あるlikeの中でidを指定する必要が出てくるが、特定の記事に対していいねは1つなので、/articles/:article_idがあればlikeは1つ（resource=1つ）でOK
    # likesテーブルにレコードを作成（=post）するのでcreate、いいねを外したときはレコードを削除するのでdestroy
    resource :like, only: [ :create, :destroy ]
  end

  # ユーザプロフィールの詳細ページを開いてフォローボタンを表示するためのURLを作成
  # usersという名前がdeviseで既に使われているので、別の名前（accounts）で定義（Userモデルを別名で扱っているだけ）
  # resourcesとして、URL上で複数あるaccountsの中でidを指定する
  resources :accounts, only: [ :show ] do
    # 指定したidのaccountをFollowするRelationshipを作る
    resources :follows, only: [ :create ]
    # 指定したidのaccountをunfollowするRelationshipを作る
    resources :unfollows, only: [ :create ]
  end

  # resourceでは単数系のリソースとして扱うため、index（複数のレコードを一覧表示するためのアクション）が用意されない
  # プロフィールは1ユーザに対して1プロフィールなので、indexは不要
  resource :profile, only: [ :show, :edit, :update ]
  # 「いいね」した記事一覧を表示するためのURLを定義
  resources :favorites, only: [ :index ]
end
