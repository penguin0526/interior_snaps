class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :post_params, only: [:create, :destroy]

  def create
    if Favorite.create(user_id: current_user.id, post_id: @post.id)
      redirect_to post_path(@post.id)
    end
  end

  def destroy
    if favorite = Favorite.find_by(user_id: current_user.id, post_id: @post.id)
      favorite.destroy
      redirect_to post_path(@post.id)
    end
  end

  private

  def post_params
    @post = Post.find(params[:post_id])
  end
end
