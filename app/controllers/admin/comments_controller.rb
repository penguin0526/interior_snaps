class Admin::CommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id]), notice: 'コメントを削除しました。'
  end
end
