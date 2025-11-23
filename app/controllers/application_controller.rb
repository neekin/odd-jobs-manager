class ApplicationController < ActionController::Base
  helper_method :current_admin, :admin_signed_in?

  private

  # 优先从 session，其次从持久签名 cookie 读取 admin
  def current_admin
    return @current_admin if defined?(@current_admin)

    if session[:admin_id].present?
      @current_admin = Admin.find_by(id: session[:admin_id])
    elsif cookies.signed[:admin_id].present?
      # cookies.signed 已签名，仍需在服务端查找并验证
      @current_admin = Admin.find_by(id: cookies.signed[:admin_id])
    else
      @current_admin = nil
    end
  end

  def admin_signed_in?
    current_admin.present?
  end

  # 在需要登录的 controller（如 SPA）调用，未登录则重定向到 /login
  def authenticate_admin!
    unless admin_signed_in?
      respond_to do |format|
        format.html { redirect_to login_path }
        format.json { render json: ({ error: "unauthenticated" }), status: :unauthorized }
      end
    end
  end
end
