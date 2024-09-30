class Public::HomesController < ApplicationController
  def top
  end

  def about
    @tag_lists = InteriorTag.all
  end
end
