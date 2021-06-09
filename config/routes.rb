# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root 'home#index'

  scope :api do
    namespace :v1 do
      post 'user/login' => 'users#login' # ----------------------------------------------------> autenticacion por credenciales
      get 'user/current' => 'users#auto_login' # ----------------------------------------------> autenticacion por token
      resources :users, only: %i[create show index]
      resources :groups
      resources :tasks
    end
  end
end
