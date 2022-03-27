# frozen_string_literal: true

class UserSerializer < ApplicationSerializer
  attributes :id, :age, :name, :email, :dataset, :created_at, :updated_at
end
