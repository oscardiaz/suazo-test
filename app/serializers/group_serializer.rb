
# frozen_string_literal: true

# serializer for tgroups
class GroupSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :updated_at
  has_many :tasks, each_serializer: TaskSerializer
end
