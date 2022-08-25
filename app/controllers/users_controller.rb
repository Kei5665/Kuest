class UsersController < ApplicationController
  before_action :set_current_user, only: %i[edit update]

  def edit;end

  def update
    if @user.update(update_params)
      redirect_to quests_path, success: "変更が成功しました"
    else
      flash.now[:danger] = "変更に失敗しました"
      render :edit
    end
  end

  def show
    @post = current_user.ordered_quests.last

    clear_num = current_user.clear_num
    @level_statement = current_user.select_emblem(clear_num)

    @emblem = current_user.current_emblems.last
  end

  private

  def update_params
    params.require(:user).permit(:name)
  end

  def set_current_user
    @user = current_user
  end
end
