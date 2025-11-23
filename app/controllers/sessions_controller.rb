class SessionsController < ApplicationController
  # 不跳过 CSRF：保证所有写操作受 Rails CSRF 保护

  def create
    admin = Admin.find_by(username: params[:username])
    if admin&.authenticate(params[:password])
      # 防止 session fixation
      reset_session

      if ActiveModel::Type::Boolean.new.cast(params[:autoLogin])
        # 持久签名 cookie（同源安全），14 天有效，HttpOnly 避免 JS 读取
        cookies.signed[:admin_id] = {
          value: admin.id,
          expires: 14.days.from_now,
          secure: Rails.env.production?,
          same_site: :lax,
          httponly: true
        }
      else
        session[:admin_id] = admin.id
      end

      render json: { ok: true, user: { id: admin.id, username: admin.username } }
    else
      render json: { error: "invalid_credentials" }, status: :unauthorized
    end
  end

  def destroy
    # 清理 session 与持久 cookie
    reset_session
    cookies.delete(:admin_id)
    head :no_content
  end

  def current
    if current_admin
      render json: { user: { id: current_admin.id, username: current_admin.username } }
    else
      render json: { user: nil }
    end
  end

  private

  def current_admin
    # ApplicationController 也实现了优先 session 然后 signed cookie 的逻辑，
    # 保持一致性：这里仅从 session 中读取，ApplicationController#current_admin 在其他地方可使用。
    @current_admin ||= Admin.find_by(id: session[:admin_id])
  end
end
