class Admin::PostsController < ApplicationController
  def index
    @post = Post.new
    @posts = Post.all
    gon.json = @posts.to_json
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to admin_posts_path, success: "投稿に成功しました！"
    else
      render turbo_stream: turbo_stream.replace(
        'post_error',
        partial: 'shared/error_messages',
        locals: { object: @post },
      )
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
    redirect_to admin_posts_path, success: "削除に成功しました！"
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :latlng, :image, :place, :date, :target, :url)
  end
end
