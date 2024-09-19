class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
    @post = Post.new
    @tag_list = InteriorTag.all

    if params[:search].present?
      @posts = Post.posts_serach(params[:search])
    elsif params[:interior_tag_id].present?
      @tag = InteriorTag.find(params[:interior_tag_id])
      @posts = @tag.posts.order(created_at: :desc)
    else
      @posts = Post.all.order(created_at: :desc)
    end
    @tag_lists = InteriorTag.all
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    @tag_list = @post.interior_tags.pluck(:name).join(',')
    @post_interior_tags = @post.interior_tags
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    tag_list = params[:post][:name].split(',')
    if @post.save
      @post.save_interior_tags(tag_list)
      redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.interior_tags.pluck(:name).join(',')
  end

  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
    tag_list = params[:post][:name].split(',')
    if @post.update(post_params)
      @post.save_interior_tags(tag_list)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_path(@user.id)
  end

  def search_tag
    @tag_list = InteriorTag.all
    @tag = InteriorTag.find(params[:interior_tag_id])
    @posts = @tag.posts.all
    if params[:interior_tag_id]
      @selected_interior_tag = InteriorTag.find(params[:interior_tag_id])
      @posts = Post.from_interior_tag(params[:interior_tag_id])
    else
      @posts = Post.all
    end
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
    @post = Post.find(params[:id])
    @user = @post.user
    redirect_to(posts_path) unless @user == current_user
  end

end
