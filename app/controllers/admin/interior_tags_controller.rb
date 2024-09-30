class Admin::InteriorTagsController < ApplicationController

  def destroy
    @interior_tag = InteriorTag.find(params[:id])
    @interior_tag.destroy
    redirect_to admin_tag_list_path, notice: 'タグを削除しました。'
  end
end
