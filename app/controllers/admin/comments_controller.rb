class Admin::CommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to admin_comment_list_path, notice: 'コメントを削除しました。'
  end
end
