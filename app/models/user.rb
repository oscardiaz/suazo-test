# frozen_string_literal: true

# Controller for user
class User < ApplicationRecord
  has_secure_password
  before_validation { assign_attributes(email: email.to_s.downcase) }
  validates :email, uniqueness: true, email: true
end
