class QuestsController < ApplicationController
  before_action :require_login, only: %i[index]

  def index
    @posts = current_user.posts.joins(:stamps).where(quests: {quest_cleared: false})
    gon.json = @posts.to_json
  end

  def set
    post = Post.find(params[:id])
    if current_user.ordered_quests.include?(post)
      redirect_to root_path, warning: "このクエストは受注済みです"  
    else
      current_user.stamps_posts << post
      redirect_to quests_path, success: "クエストを開始します！"  
    end
  end

  def destroy
    post = Post.find(params[:id])
    quest = current_user.stamps.find_by(post_id: post.id)
    quest.destroy!
    redirect_to quests_path, success: "クエストをキャンセルしました！"  
  end
end
