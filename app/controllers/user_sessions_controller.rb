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
    redirect_to areas_path, success: 'ゲストでログインしました！'
  end
end
