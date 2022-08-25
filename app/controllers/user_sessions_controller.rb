class UserSessionsController < ApplicationController
  def destroy
    logout
    redirect_to root_path, success: 'ログアウトしました'
  end

  def guest_login

    random_value = SecureRandom.hex
    user = User.create!(name: "ゲスト", email: "test_#{random_value}@example.com",)
    auto_login(user)

    post = Post.find(params[:post_id])
    emblem = Emblem.first
    current_user.user_emblems.create(emblem_id: emblem.id)
    current_user.ordered_quests << post
    redirect_to quests_path, success: "ゲストでログインしました！クエストを開始します！"
  end
end
