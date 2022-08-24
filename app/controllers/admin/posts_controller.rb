class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all.order(area_id: :desc)
  end

  # def edit
  #   @post = Post.find(params[:id])
  # end

  # def update
  #   @post = Post.find(params[:id])
  #   if @post.update(post_params)
  #     redirect_to admin_posts_path, success: "更新成功しました"
  #   else
  #     redirect_to admin_posts_path, danger: "更新失敗しました"
  #     render :new
  #   end
  # end

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

  # def post_params
  #   params.require(:post).permit(:title, :body, :latlng, :image, :place, :date, :time, :price, :address)
  # end

  def product_collection_params
    params.require(:form_product_collection)
    .permit(posts_attributes: [:title, :latitude, :longitude, :place, :date, :time, :price, :address, :area_id, :availability, :url, :start_date, :finish_date])
  end
end
