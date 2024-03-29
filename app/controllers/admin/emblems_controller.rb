class Admin::EmblemsController < Admin::BaseController

  def index
    @emblems = Emblem&.all
  end

  def new
    @emblem = Emblem.new
  end

  def create
    @emblem = Emblem.new(emblem_params)
    if @emblem.save
      redirect_to admin_posts_path, success: "エンブレムを作成しました"
    else
      binding.pry
      render :new
    end
  end

  def destroy
    @emblem = Emblem.find(params[:id])
    @emblem.destroy!
    redirect_to admin_posts_path, success: "削除に成功しました！"
  end


private

  def emblem_params
    params.require(:emblem).permit(:name, :limit_num, :emblem_image)
  end
end
