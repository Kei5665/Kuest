class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all.order(area_id: :desc)
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to admin_posts_path, success: "投稿に成功しました！"
    else
      flash.now[:error] = "投稿に失敗しました"
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to admin_posts_path, success: "更新成功しました"
    else
      redirect_to admin_posts_path, danger: "更新失敗しました"
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
    redirect_to admin_posts_path, success: "削除に成功しました！"
  end

  def scrape
    Scraping.new(id:params[:id])
  end

  def destroy_all
    posts = Post.all
    posts.destroy_all
    redirect_to admin_posts_path, success: "全データ削除に成功しました！"
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :latlng, :image, :place, :date, :time, :price, :address)
  end
end
