class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_user_list_path, notice: 'ユーザーを削除しました。'
  end
end
