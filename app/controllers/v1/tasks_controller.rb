# frozen_string_literal: true

# controller for class task
class V1::TasksController < ApplicationController
  before_action :authorized

  def index
    tasks = @current_user.tasks
    render json: tasks, status: 200
  end

  def create
    return head(:not_found) unless @current_user.groups.exists?(params[:task][:group_id])

    task = Task.new(permit_params)
    if task.save
      render json: task, status: 200
    else
      render json: { messages: task.errors.messages }, status: 400
    end
  end

  def update
    return render json: { messages: 'not found' }, status: 404 unless @current_user.tasks.exists?(params[:id])

    task = @current_user.tasks.find(params[:id])
    if task.update(permit_params)
      render json: task, status: 200
    else
      render json: { messages: task.errors.messages }, status: 400
    end
  end

  def destroy
    return render json: { messages: 'not found' }, status: 404 unless @current_user.tasks.exists?(params[:id])

    task = @current_user.tasks.find(params[:id])
    if task.destroy
      render json: task, status: 200
    else
      render json: { messages: task.errors.messages }, status: 400
    end
  end

  private

  def permit_params
    params.require(:task).permit(:title, :description, :status, :group_id)
  end
end
