class UserSessionsController < ApplicationController
  def destroy
    logout
    redirect_to boards_path, success: 'ログアウトしました'
  end
end
