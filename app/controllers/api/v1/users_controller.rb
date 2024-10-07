class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show destroy]

  def index
    users = User.all.order(created_at: :desc)
    render json: users
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def show
    if @user
      render json: @user
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  def destroy
    @user&.destroy
    render json: { message: "User deleted" }
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone, :age, :address, :area, :image)
  end
end
