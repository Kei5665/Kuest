class StampsController < ApplicationController
  def create
    post = Post.find(params[:id])
    post.save!
    redirect_to root_path, success: "スタンプを完了しました！"
  end
end