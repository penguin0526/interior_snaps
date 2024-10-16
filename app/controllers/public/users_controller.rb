class Public::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:favorites]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.page(params[:page])
    @post = Post.new
    @tag_lists = InteriorTag.all
  end

  def update
    @user = User.find(params[:id])
    if  @user.update(user_params)
      redirect_to user_path(@user.id), notice: "ユーザーネームを変更しました。"
    else
      flash.now[:error] = @user.errors.full_messages.join(", ")
      render :edit
    end
  end

  def edit
    @user = User.find(params[:id])
    @tag_lists = InteriorTag.all
  end

  def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to :root, notice: "退会しました。"
  end

  def favorites
    favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.where(id: favorites).page(params[:page])
    @tag_lists = InteriorTag.all
    @posts = @favorite_posts
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless @user == current_user
  end

  def set_user
    @user = User.find(params[:id])
  end
end
