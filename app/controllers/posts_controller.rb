class PostsController < ApplicationController
  def index
    @posts = Post.all
    gon.json = @posts.to_json
    if current_user
      @finished_quests = current_user.posts.joins(:stamps).where(stamps: {stamped: true})
    end
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to root_path, success: "投稿に成功しました！"
    else
      render turbo_stream: turbo_stream.replace(
        'post_error',
        partial: 'shared/error_messages',
        locals: { object: @post },
      )
    end
  end

  def stamped
    stamp = current_user.stamps.find_by(post_id: params[:id])
    stamp.stamped = true
    stamp.save!
    redirect_to root_path, success: "クエストを完了しました！"
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :latlng, :image)
  end
end
