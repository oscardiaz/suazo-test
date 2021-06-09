# frozen_string_literal: true

# class task
class Task < ApplicationRecord
  belongs_to :group, class_name: 'Group'
  validates_presence_of :title
  validates_presence_of :description

  accepts_nested_attributes_for :group

  enum status: { pending: 0, finished: 1 }
end
