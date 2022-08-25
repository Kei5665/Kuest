class Admin::AreasController < Admin::BaseController

  def index
    @areas = Area&.all
  end

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

  def destroy
    @area = Area.find(params[:id])
    @area.destroy!
    redirect_to admin_posts_path, success: "削除に成功しました！"
  end

private

  def area_params
    params.require(:area).permit(:area_name, :spelling)
  end
end
