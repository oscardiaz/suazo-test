# frozen_string_literal: true

# controller for class group
class V1::GroupsController < ApplicationController
  before_action :authorized

  def index
    groups = @current_user.groups
    render json: groups, status: 200
  end

  # def show
  #   @ = .find(params[:id])
  # end

  def create
    group = Group.new(permit_params)
    group.user = @current_user
    if group.save
      render json: group, status: 200
    else
      render json: { messages: group.errors.messages }, status: 400
    end
  end

  def update
    return render json: { messages: 'not found' }, status: 404 unless @current_user.groups.exists?(params[:id])

    group = @current_user.groups.find(params[:id])
    if group.update(permit_params)
      render json: group, status: 200
    else
      render json: { messages: group.errors.messages }, status: 400
    end
  end

  def destroy
    return render json: { messages: 'not found' }, status: 404 unless @current_user.groups.exists?(params[:id])

    group = @current_user.groups.find(params[:id])
    if group.destroy
      render json: group, status: 200
    else
      render json: { messages: group.errors.messages }, status: 400
    end
  end

  private

  def permit_params
    params.require(:group).permit(:title, :user_id,
                                  tasks_attributes: %i[id title description status _destroy])
  end
end
