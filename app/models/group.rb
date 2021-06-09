# frozen_string_literal: true

# class group
class Group < ApplicationRecord
  belongs_to :user, class_name: 'User'
  has_many :tasks, class_name: 'Task', dependent: :destroy
  accepts_nested_attributes_for :tasks, allow_destroy: true

  validates_presence_of :title
end
