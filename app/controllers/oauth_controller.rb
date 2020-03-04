class OauthController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]

    if @user = login_from(provider)
      Token.create!(
        user_id: current_user.id,
        token: access_token.token,
        refresh_token: access_token.refresh_token,
        expires_at: DateTime.strptime(access_token.expires_at.to_s, '%s')
      )

      redirect_to root_path, notice: "Logged in from #{provider.titleize}! (login_from)"
      return
    end

    @user = create_from(provider)
    reset_session # protect from session fixation attack
    auto_login(@user)

    Token.create!(
      user_id: current_user.id,
      token: access_token.token,
      refresh_token: access_token.refresh_token,
      expire_at: DateTime.strptime(access_token.expires_at.to_s, '%s')
    )

    redirect_to root_path, notice: "Logged in from #{provider.titleize}!"
  end

  private

  def auth_params
    params.permit(:provider, :code, :scope, :session_state, :prompt, :authuser)
  end
end
