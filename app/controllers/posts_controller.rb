class PostsController < ApplicationController
  def index
    @posts = Post.all
    gon.json = @posts.to_json
    if current_user
      @finished_quests = current_user.posts.joins(:quests).where(quests: {quest_cleared: true})
    end
  end

  def stamped
    stamp = current_user.stamps.find_by(post_id: params[:id])
    stamp.stamped = true
    stamp.save!
    redirect_to root_path, success: "クエストを完了しました！"
  end
end
