class UserSessionsController < ApplicationController
  def destroy
    logout
    redirect_to root_path, success: 'ログアウトしました'
  end

  def guest_login
    redirect_to areas_path, error: 'すでにログインしています' if current_user # ログインしてる場合はユーザーを作成しない

    random_value = SecureRandom.hex
    user = User.create!(name: "ゲスト", email: "test_#{random_value}@example.com",)
    auto_login(user)

    post = Post.find(params[:post_id])
    if current_user.ordered_quests.include?(post)
      redirect_to post_path(post), warning: "このクエストは受注済みです"  
    else
      current_user.ordered_quests << post
      redirect_to quests_path, success: "ゲストでログインしました！クエストを開始します！"  
    end
  end
end
