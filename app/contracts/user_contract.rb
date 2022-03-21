# frozen_string_literal: true

class UserContract < ApplicationContract
  params do
    required(:name).value(:string)
    required(:email).value(:string)
  end

  rule(:email) do
    unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
      key.failure('has invalid format')
    end
  end
end
