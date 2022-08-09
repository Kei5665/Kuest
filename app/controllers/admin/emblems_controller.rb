class Admin::EmblemsController < ApplicationController
  def new
    @emblem = Emblem.new
  end

  def create
    @emblem = Emblem.new(emblem_params)
    if @emblem.save
      redirect_to admin_posts_path, success: "エンブレムを作成しました"
    else
      render :new
    end
  end
end

private

def emblem_params
  params.require(:emblem).permit(:name, :limit_num, :emblem_image)
end
