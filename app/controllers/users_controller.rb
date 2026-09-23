class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:update, :destroy]
  before_action :authorize_user_management

  def index
    @users = User.visible_users.order(role: :desc, created_at: :desc)
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: "User role updated successfully."
    else
      redirect_to users_path, alert: "Failed to update user role."
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_path, notice: "User deleted successfully."
    else
      redirect_to users_path, alert: "Failed to delete user."
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:role)
  end

  def authorize_user_management
    unless current_user.admin? || current_user.super_admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end