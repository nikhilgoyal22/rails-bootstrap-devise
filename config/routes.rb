Rails.application.routes.draw do
  root to: 'secret_codes#index'
  resources :secret_codes
  devise_for :users, :skip => [:sessions], :controllers => {
    :registrations => "users/registrations",
  }

  devise_scope :user do
    get '/users/sign_in', to: 'users/sessions#new', as: 'new_user_session'
    post '/users/sign_in', to: 'users/sessions#create', as: 'user_session'
    delete '/users/sign_out', to: 'users/sessions#destroy', as: 'destroy_user_session'
    get '/users/sign_out', to: 'users/sessions#destroy'
    get '/users/index', to: 'users/sessions#user_index'
  end

  post '/generate_codes', to: 'secret_codes#generate_codes'
end

