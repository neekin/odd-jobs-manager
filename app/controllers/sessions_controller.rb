class SessionsController < ApplicationController
  # 仅当请求为 JSON 时允许跳过 verify_authenticity_token（前端会发送 X-CSRF-Token）
  skip_before_action :verify_authenticity_token, only: [ :create ], if: -> { request.format.json? }

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { ok: true, user: { id: user.id, email: user.email } }
    else
      render json: { error: "invalid_credentials" }, status: :unauthorized
    end
  end

  def destroy
    reset_session
    head :no_content
  end

  def current
    if current_user
      render json: { user: { id: current_user.id, email: current_user.email } }
    else
      render json: { user: nil }
    end
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
