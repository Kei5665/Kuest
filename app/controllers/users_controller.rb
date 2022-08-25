class UsersController < ApplicationController
  before_action :set_current_user, only: %i[edit update show]

  def edit;end

  def update
    if @user.update(update_params)
      redirect_to quests_path, success: "変更登録が成功しました"
    else
      flash.now[:danger] = "変更登録に失敗しました"
      render :edit
    end
  end

  def show
    @post = @user.ordered_quests.last

    clear_num = @user.clear_num
    @level_statement = @user.select_emblem(clear_num)

    @emblem = @user.current_emblems.last
  end

  private

  def update_params
    params.require(:user).permit(:name,:email,:password)
  end

  def set_current_user
    @user = current_user
  end
end
