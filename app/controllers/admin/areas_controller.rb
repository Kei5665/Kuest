class Admin::AreasController < ApplicationController
  def new
    @area = Area.new
  end

  def create
    @area = Area.new(area_params)
    if @area.save
      redirect_to admin_posts_path, success: "新しいエリアを作成しました"
    else
      render :new
    end
  end

private

  def area_params
    params.require(:area).permit(:area_name, :spelling)
  end
end
