# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # root 'home#index'

  scope :api do
    namespace :v1 do
      post 'user/login' => 'users#login' # ----------------------------------------------------> autenticacion por credenciales
      get 'user/current' => 'users#auto_login' # ----------------------------------------------> autenticacion por token
      resources :users, only: %i[create]
      resources :groups
      resources :tasks
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

# crear grupo
# api/v1/groups -> post
# headers
# Authorization: Bearer ${token}
# body
# {
# 	"group": {
# 		"title": "Group 1",
# 	  "tasks_attributes": [ <-------- opcional
# 			{
# 				"title": "Taks 1, Group 1",
# 				"description": "Lorem ipsum dolor sit amet consectetur adipisicing elit. Suscipit dolor recusandae earum architecto quam dolores reiciendis ut quae itaque"
# 			}
# 		]
# 	}
# }
# retorna
# {
#   "id": 1,
#   "title": "Group 1",
#   "created_at": "2021-06-08T23:27:05.642Z",
#   "updated_at": "2021-06-08T23:27:05.642Z",
#   "tasks": [
#       {
#           "id": 1,
#           "title": "Taks 1, Group 1",
#           "description": "Lorem ipsum dolor sit amet consectetur adipisicing elit. Suscipit dolor recusandae earum architecto quam dolores reiciendis ut quae itaque",
#           "status": "pending",
#           "created_at": "2021-06-08T23:27:05.642Z",
#           "updated_at": "2021-06-08T23:27:05.642Z"
#       }
#   ]
# }

# ver grupos
# api/v1/groups -> get
# headers
# Authorization: Bearer ${token}
# retorna
# [
#   {
#     "id": 1,
#     "title": "Group 1",
#     "created_at": "2021-06-08T23:21:46.173Z",
#     "updated_at": "2021-06-08T23:21:46.173Z",
#     "tasks": []
#   },
#   {
#     "id": 2,
#     "title": "Group 2",
#     "created_at": "2021-06-08T23:21:46.173Z",
#     "updated_at": "2021-06-08T23:21:46.173Z",
#     "tasks": [
#         {
#             "id": 1,
#             "title": "Taks 1, Group 2",
#             "description": "Lorem ipsum dolor sit amet consectetur adipisicing elit. Suscipit dolor recusandae earum architecto quam dolores reiciendis ut quae itaque",
#             "status": "pending",
#             "created_at": "2021-06-08T23:23:47.628Z",
#             "updated_at": "2021-06-08T23:23:47.628Z"
#         }
#     ]
#   }
# ]

# editar grupo
# api/v1/groups/:id -> put
# headers
# Authorization: Bearer ${token}
# body
# {
# 	"group": {
# 		"title": "Group 1",
# 	  "tasks_attributes": [ <-------- opcional
#       {
# 				"title": "Taks 2, Group 1",
# 				"description": "Lorem ipsum dolor sit amet consectetur adipisicing elit. Suscipit dolor recusandae earum architecto quam dolores reiciendis ut quae itaque"
# 			},
# 			{
#         "id": 1,
# 				"title": "Taks 1, Group 1",
# 				"description": "Lorem ipsum dolor sit amet consectetur adipisicing elit. Suscipit dolor recusandae earum architecto quam dolores reiciendis ut quae itaque"
# 			  "status": "pending" -> posibles valores [pending, finished]
#         "_destroy": 1 <- opcional si se envia con valor 1 se elmina la tarea algun otro valor se ignora
# 			}
# 		]
# 	}
# }
# respuesta
# "id": 1,
# "title": "Group 1, edited",
# "created_at": "2021-06-08T23:21:46.173Z",
# "updated_at": "2021-06-09T00:10:11.490Z",
# "tasks": [
#     {
#         "id": 2,
#         "title": "Taks 2, Group 1, new",
#         "description": "Lorem ipsum dolor sit amet consectetur adipisicing elit. Suscipit dolor recusandae earum architecto quam dolores reiciendis ut quae itaque",
#         "status": "pending",
#         "created_at": "2021-06-09T00:12:16.393Z",
#         "updated_at": "2021-06-09T00:19:34.281Z"
#     }
# ]

# eleminar grupo
# api/v1/groups/:id -> delete
# headers
# Authorization: Bearer ${token}
# respuesta
#   {
#     "id": 1,
#     "title": "Group 1",
#     "created_at": "2021-06-08T23:21:46.173Z",
#     "updated_at": "2021-06-08T23:21:46.173Z",
#     "tasks": []
#   }
