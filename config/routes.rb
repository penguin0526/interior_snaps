Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
    resources :posts, only: [:show, :destroy]
    resources :comments, only: [:destroy]
    resources :interior_tags, only: [:destroy]
    get 'user_list' => 'dashboards#user_list'
    get 'tag_list' => 'dashboards#tag_list'
    get 'comment_list' => 'dashboards#comment_list'
  end

  scope module: :public do
    devise_for :users
    resources :users do
      member do
        get :favorites
      end
    end
    resources :posts do
      resources :comments, only: [:create]
      resources :favorites, only: [:create, :destroy]
    end
    resources :interior_tags do
      get 'posts', to: 'posts#search'
    end
    root to: 'posts#index'
    get '/about' => 'homes#about', as: 'about'
    get 'search_tag' => 'posts#search_tag'
    get 'tag_list' => 'posts#tag_list'
  end
end
