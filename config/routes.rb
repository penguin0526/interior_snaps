Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  devise_for :users
  resources :favorites, only: [:create, :destroy, :index]
  resources :comments, only: [:new, :create, :edit, :update, :destroy]
  resources :posts, only: [:new, :index, :show, :create, :edit, :update, :destroy]
  resources :users, only: [:edit, :show, :update, :destroy]
  root to: 'homes#top'
  get '/about' => 'homes#about', as: 'about'
  get '/mypage' => 'users#mypage', as:'mypage'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
