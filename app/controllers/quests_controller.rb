class QuestsController < ApplicationController
  before_action :require_login, only: %i[index]

  def index
    @posts = current_user.posts.joins(:quests).where(quests: {quest_cleared: false})
    gon.json = @posts.to_json
  end

  def create
    post = Post.find(params[:id])
    if current_user.ordered_quests.include?(post)
      redirect_to root_path, warning: "このクエストは受注済みです"  
    else
      current_user.ordered_quests << post
      redirect_to quests_path, success: "クエストを開始します！"  
    end
  end

  def destroy
    post = Post.find(params[:id])
    quest = current_user.ordered_quests.find_by(post_id: post.id)
    quest.destroy!
    redirect_to quests_path, success: "クエストをキャンセルしました！"  
  end

  def clear
    quest = current_user.quests.find_by(post_id: params[:id])
    quest.quest_cleared = true
    quest.save!
    redirect_to root_path, success: "クエストを完了しました！"
  end
end
