# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::API
  # codifica el token
  def encode_token(payload)
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end

  # me retorna al header de autorizacion
  def auth_header
    request.headers['Authorization']
  end

  # decodifica el token de autenticacion del header del request
  def decoded_token
    return unless auth_header

    token = auth_header.split(' ')[1]
    begin
      JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: 'HS256')
    rescue JWT::DecodeError
      nil
    end
  end

  # verigica que tengo header de autenticacion lo decodifica
  # y retorna el usuario al que pertenece el token
  def logged_in_user
    return unless decoded_token

    user_id = decoded_token[0]['user_id']
    @current_user = User.find_by(id: user_id)
  end

  # llama al proceso de autenticacion
  def logged_in?
    !!logged_in_user
  end

  # autenctica el usuario a travez del token de header del request
  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
