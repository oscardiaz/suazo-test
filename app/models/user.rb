# frozen_string_literal: true

# class user
class User < ApplicationRecord
  has_secure_password
  before_validation { assign_attributes(email: email.to_s.downcase) }
  validates :email, uniqueness: true, email: true

  has_many :groups, class_name: 'Group'

  has_many :tasks, class_name: 'Task', through: :groups
end
