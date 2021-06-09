# frozen_string_literal: true

# basic serializer four user model
class User::ShowSerializer < ActiveModel::Serializer
  attributes :id, :email
  has_many :groups, each_serializer: GroupSerializer
end
