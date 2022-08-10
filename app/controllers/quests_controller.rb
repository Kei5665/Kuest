class QuestsController < ApplicationController
  before_action :require_login, only: %i[index]

  def index
    @posts = current_user.ordered_quests.joins(:quests).where(quests: {quest_cleared: false})
    gon.json = @posts.to_json
    @finished_quests = current_user.ordered_quests.joins(:quests).where(quests: {quest_cleared: true})
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
    quest = current_user.quests.find_by(post_id: post.id)
    quest.destroy!
    redirect_to quests_path, success: "クエストをキャンセルしました！"  
  end

  def clear
    @post = current_user.ordered_quests.find(params[:id])
    quest = current_user.quests.find_by(post_id: params[:id])
    quest.quest_cleared = true
    quest.save!

    clear_num = current_user.clear_num += 1
    current_user.select_emblem(clear_num).
  end
end
