# frozen_string_literal: true

class UserSerializer < ApplicationSerializer
  attributes :id, :name, :email, :dataset, :description, :created_at, :updated_at
end
