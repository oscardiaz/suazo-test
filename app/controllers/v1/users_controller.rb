# frozen_string_literal: true

# Users controllers
class V1::UsersController < ApplicationController
  # lista de usuarios
  def index
    users = User.all
    render json: users, each_serializer: User::ShowSerializer, status: 200
  end

  # crea el usario
  def create
    user = User.create(user_params)
    if user.valid?
      render json: { status: 'ok' }, status: 200
    else
      render json: { messages: user.errors.messages }, status: 400
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
