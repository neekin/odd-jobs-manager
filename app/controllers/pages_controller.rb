class PagesController < ApplicationController
  before_action :redirect_if_authenticated, only: [ :login ]

  def login
    # 渲染 app/views/pages/login.html.erb（由 React 挂载）
  end

  private

  def redirect_if_authenticated
    redirect_to root_path if admin_signed_in?
  end
end
