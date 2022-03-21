# frozen_string_literal: true

class UserPresenter < ApplicationPresenter
  def initialize(user)
    @user = user
  end

  def call
    @user.attributes.merge(capt_description: capt_description)
  end

  def capt_description
    if @user.age > 30
      "Юзеру больше 30 лет"
    else
      "Юзеру не больше 30 лет"
    end
  end
end
