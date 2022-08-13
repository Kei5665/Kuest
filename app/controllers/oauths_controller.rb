class OauthsController < ApplicationController
  def oauth
    redirect_to sorcery_login_url(auth_params[:provider]), allow_other_host: true
  end

  def callback
    provider = auth_params[:provider]
    if (@user = login_from(provider))
      redirect_to quests_path, success: "#{provider.titleize}でログインしました！クエストを開始します！"
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        redirect_to quests_path, success: "#{provider.titleize}でログインしました！クエストを開始します！"
      rescue StandardError
        redirect_to root_path, danger: "#{provider.titleize}でのログインに失敗しました"
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :denied, :error, :state)
  end
end