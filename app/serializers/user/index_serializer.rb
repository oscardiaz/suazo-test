# frozen_string_literal: true

# basic serializer four user model
class User::IndexSerializer < ActiveModel::Serializer
  attributes :id, :email
end
