class PostsController < ApplicationController
  def index
    @posts = Post.all
    gon.json = @posts.to_json
    if current_user
      @finished_quests = current_user.posts.joins(:quests).where(quests: {quest_cleared: true})
    end
  end
end
