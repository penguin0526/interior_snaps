Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  devise_for :users
  resources :favorites, only: [:create, :destroy, :index]
  resources :comments, only: [:new, :create, :edit, :update, :destroy]
  resources :posts
  resources :users do
  member do
    get :favorites
  end
end
  root to: 'posts#index'
  get '/about' => 'homes#about', as: 'about'
  get '/mypage' => 'users#mypage', as:'mypage'
  get 'search_tag' => 'posts#search_tag'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
