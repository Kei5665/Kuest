class OauthsController < ApplicationController
  def oauth
    redirect_to sorcery_login_url(auth_params[:provider]), allow_other_host: true
  end

  def callback
    provider = auth_params[:provider]
    if (@user = login_from(provider))
      redirect_to areas_path, success: "#{provider.titleize}でログインしました！"
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        
        emblem = Emblem.first
        current_user.user_emblems.create(emblem_id: emblem.id)
        redirect_to areas_path, success: "#{provider.titleize}でログインしました！"
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