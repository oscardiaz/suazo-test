# frozen_string_literal: true

# serializer for tasks
class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :status, :created_at, :updated_at
end
