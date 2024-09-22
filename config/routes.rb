Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  devise_for :users
  resources :comments, only: [:new, :create, :edit, :update, :destroy]

  resources :users do
    member do
      get :favorites
    end
  end

  resources :posts do
    resources :favorites, only: [:create, :destroy]
  end

  resources :interior_tags do
    get 'posts', to: 'posts#search'
  end

  root to: 'posts#index'

  get '/about' => 'homes#about', as: 'about'
  get '/mypage' => 'users#mypage', as:'mypage'
  get 'search_tag' => 'posts#search_tag'
end
