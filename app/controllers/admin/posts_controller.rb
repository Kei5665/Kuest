class Admin::PostsController < Admin::BaseController

  def create
    @form = Form::ProductCollection.new(product_collection_params)
    if @form.save
      redirect_to root_path, notice: "投稿を登録しました"
    else
      redirect_to root_path, notice: "投稿に失敗しました"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
    redirect_to admin_posts_path, success: "削除に成功しました！"
  end

  def destroy_all
    posts = Post.all
    posts.destroy_all
    redirect_to admin_posts_path, success: "全データ削除に成功しました！"
  end

  private

  def product_collection_params
    params.require(:form_product_collection)
    .permit(posts_attributes: [:title, :latitude, :longitude, :place, :date, :time, :price, :address, :area_id, :availability, :url, :start_date, :finish_date])
  end
end
