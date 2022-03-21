# frozen_string_literal: true

class UserQuery < ApplicationQuery
  def call(filter_params)
    resources = paginate(filter_params)
  end

  private

  def paginate(params)
    params[:page].present? ? resources.limit(params[:limit]).offset(params[:page] * params[:limit] || params[:page] * DEFAULT_LIMIT) : resources
  end
end
