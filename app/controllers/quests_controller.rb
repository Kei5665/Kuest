class QuestsController < ApplicationController
  before_action :require_login, only: %i[index]

  def index
    @posts = current_user.ordered_quests.joins(:quests).where(quests: {quest_cleared: false})
    gon.json = @posts.to_json
    gon.yuusya_img = current_user.assets_path
    @finished_quests = current_user.ordered_quests.joins(:quests).where(quests: {quest_cleared: true})

    @level_statement = current_user.select_emblem(current_user.clear_num)
    @emblem = current_user.current_emblems.last
  end

  def create
    post = Post.find(params[:id])
    if current_user.ordered_quests.include?(post)
      redirect_to post_path(post), warning: "このクエストは受注済みです"  
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

    clear_num = current_user.clear_num + 1
    current_user.clear_num = clear_num
    current_user.save

    redirect_to user_path(current_user), success: "クエストをクリアしました！"  
  end
end
