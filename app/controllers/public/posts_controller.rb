class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
    @tag_lists = InteriorTag.all
  end

  def index
    @post = Post.new
    @tag_list = InteriorTag.all

    if params[:search].present?
      @posts = Post.where('title LIKE ?', "%#{params[:search]}%").page(params[:page])
    elsif params[:interior_tag_id].present?
      @tag = InteriorTag.find(params[:interior_tag_id])
      @posts = @tag.posts.order(created_at: :desc).page(params[:page])
    else
      @posts = Post.all.order(created_at: :desc).page(params[:page])
    end
    @tag_lists = InteriorTag.all
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @tag_list = @post.interior_tags.pluck(:name).join(',')
    @post_interior_tags = @post.interior_tags
    @tag_lists = InteriorTag.all
    @comment = Comment.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:name].split(',')
    if @post.save
      @post.save_interior_tags(tag_list)
      redirect_to post_path(@post.id), notice: "投稿に成功しました。"
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.interior_tags.pluck(:name).join(',')
    @tag_lists = InteriorTag.all
  end

  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    tag_list = params[:post][:name].split(',')
    if @post.update(post_params)
      @post.save_interior_tags(tag_list)
      redirect_to post_path(@post.id), notice: "投稿を変更しました。"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
  end

  def search_tag
    @post = Post.new
    @tag_list = InteriorTag.all
    @tag = InteriorTag.find(params[:interior_tag_id])
    @posts = @tag.posts.all.page(params[:page])
    @tag_lists = InteriorTag.all
    if params[:interior_tag_id]
      @selected_interior_tag = InteriorTag.find(params[:interior_tag_id])
      @posts = Post.from_interior_tag(params[:interior_tag_id]).page(params[:page])
    else
      @posts = Post.all.page(params[:page])
    end
  end

  def tag_list
    @tag_lists = InteriorTag.all.page(params[:page]).per(30)  #こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
  end

  def search
    @tag_list = InteriorTag.all  #こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    @tag = InteriorTag.find(params[:interior_tag_id])  #クリックしたタグを取得
    @posts = @tag.posts.all           #クリックしたタグに紐付けられた投稿を全て表示
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :user_id, images: [])
  end

  def correct_user
    @post = current_user.posts.find_by_id(params[:id])
    redirect_to root_path unless @post
  end
end