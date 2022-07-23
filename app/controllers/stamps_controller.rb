class StampsController < ApplicationController
  def index
    @posts = current_user.posts.joins(:stamps).where(stamps: {stamped: false})
    gon.json = @posts.to_json
  end

  def set
    post = Post.find(params[:id])
    if current_user.stamps_posts.include?(post)
      post.errors.add :stamp, "はすでにセットしています"
      render turbo_stream: turbo_stream.replace(
        'stamp_error',
        partial: 'shared/error_messages',
        locals: { object: post },
      )
    else
      current_user.stamps_posts << post
      redirect_to stamps_path, success: "クエストを開始します！"  
    end
  end
end
