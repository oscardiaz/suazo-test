# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root 'home#index'

  scope :api do
    namespace :v1 do
      post 'user/login' => 'users#login' # ----------------------------------------------------> login
      get 'user/current' => 'users#auto_login' # ----------------------------------------------> auto_login
      resources :users
    end
  end
end

# crear usuario
# api/v1/users -> post
# body
# {
# 	"user": {
# 		"email": "samuel021093@gmail.com",
# 		"password": "Password123",
# 		"password_confirmation": "Password1234"
# 	}
# }

# lista de usuarios
# api/v1/users -> get
# retorna
# [
#   {
#       "id": 1,
#       "email": "samuel021093@gmail.com"
#   }
# ]

# autenticacion por credenciales
# api/v1/user/login -> post
# body
# {
# 	"auth": {
# 		"email": "samuel021093@gmail.com",
# 		"password": "Password123"
# 	}
# }
# retorna
# {
#   "user": {
#       "id": 1,
#       "email": "samuel021093@gmail.com",
#       "password_digest": "$2a$12$cvNNp9zSAFwQxEl4klFO3..SMGLyg8KZR.0nQw2ZlLRFGDb60DI2u",
#       "created_at": "2021-06-08T21:10:36.584Z",
#       "updated_at": "2021-06-08T21:10:36.584Z"
#   },
#   "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJjcmVhdGVkX2F0IjoxNjIzMTkwOTM2fQ.aGu3Wqti6-hbQpHZ7Os1e3pdp0uGGT1XSHzzsdRKMIY"
# }

# autenticacion por token
# api/v1/user/current -> get
# headers
# Authorization: Bearer ${token}
# retorna
# {
#   "id": 1,
#   "email": "samuel021093@gmail.com"
# }
