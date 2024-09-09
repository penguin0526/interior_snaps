class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def update
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
  end
end
