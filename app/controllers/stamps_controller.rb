class StampsController < ApplicationController
  def index
    @posts = current_user.posts.joins(:stamps).where(stamps: {stamped: false})
    gon.json = @posts.to_json
  end

  def set
    post = Post.find(params[:id])
    if current_user.stamps_posts.include?(post)
      redirect_to root_path, warning: "このクエストは受注済みです"  
    else
      current_user.stamps_posts << post
      redirect_to stamps_path, success: "クエストを開始します！"  
    end
  end
end
