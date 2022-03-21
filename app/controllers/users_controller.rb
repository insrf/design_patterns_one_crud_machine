# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i(show update destroy)
  before_action :validate, only: %i(create update)

  # GET /users
  def index
    @users = UserQuery.new(User.all).call(filter_params)

    render json: @users, each_serializer: UserCollectionSerializer
  end

  # GET /users/1
  def show
    @result = UserPresenter.new(@user).call
    render json: @result
  end

  # POST /users
  def create
    if @result.errors
      render json: @result.errors, status: :unprocessable_entity
    else
      @user = User.create!(user_params)
      render json: @user, serializer: UserSerializer, status: :created
    end
  end

  # PATCH/PUT /users/1
  def update
    if @result.errors
      render json: @result.errors, status: :unprocessable_entity
    else
      @user = User.update!(user_params)
      render json: @user, serializer: UserSerializer, status: :created
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private

  def validate
    @result = UserContract.new.call(user_params)
  end
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :email, :age)
  end

  def filter_params
    params.permit(:page, :limit)
  end
end
