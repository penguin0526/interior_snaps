class Admin::DashboardsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def index
    @post = Post.new
    @tag_list = InteriorTag.all

    if params[:search].present?
      @posts = Post.posts_serach(params[:search]).page(params[:page]).per(50)
    elsif params[:interior_tag_id].present?
      @tag = InteriorTag.find(params[:interior_tag_id])
      @posts = @tag.posts.order(created_at: :desc).page(params[:page]).per(50)
    else
      @posts = Post.all.order(created_at: :desc).page(params[:page]).per(50)
    end
    @tag_lists = InteriorTag.all
  end

  def user_list
    @users = User.all.page(params[:page]).per(100)
  end

  def tag_list
    @tag_lists = InteriorTag.all.page(params[:page]).per(100)
  end

  def comment_list
    @comments = Comment.all.page(params[:page]).per(50)
    @users = User.all
  end

end
