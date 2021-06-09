# frozen_string_literal: true

# Users controllers
class V1::UsersController < ApplicationController
  before_action :authorized, only: %i[auto_login show]

  # lista de usuarios
  def index
    users = User.all
    render json: users, each_serializer: User::IndexSerializer, status: 200
  end

  # ver un usuario
  def show
    render json: @current_user, serializer: User::ShowSerializer, status: 200
  end

  # crea el usario
  def create
    user = User.create(permit_params)
    if user.valid?
      render json: { status: 'ok' }, status: 200
    else
      render json: { messages: user.errors.messages }, status: 400
    end
  end

  # autentica atravez de email y password del usaurio
  def login
    user = User.find_by(email: params[:auth][:email].downcase)
    if user&.authenticate(params[:auth][:password])
      token = encode_token({ user_id: user.id, created_at: Time.now.to_i })
      render json: { user: user, token: token }, status: 200
    else
      render json: { messages: 'Invalid email or password' }, status: 404
    end
  end

  # autenticacion atravez del token
  def auto_login
    render json: @current_user, serializer: User::IndexSerializer, status: 200
  end

  private

  def permit_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
