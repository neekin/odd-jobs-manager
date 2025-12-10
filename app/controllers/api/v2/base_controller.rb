module Api
  module V2
    class BaseController < ActionController::API
      before_action :ensure_json_request

      # 若需要认证，请在子类启用此 before_action
      # before_action :authenticate_by_token

      rescue_from StandardError do |e|
        Rails.logger.error("[API V2] #{e.class}: #{e.message}\n#{e.backtrace&.join("\n")}")
        render json: { error: "internal_server_error" }, status: :internal_server_error
      end

      private

      def ensure_json_request
        request.format = :json
      end

      # 简单的 token 验证示例（按需替换为真实实现）
      def authenticate_by_token
        token = request.headers["Authorization"]&.to_s&.sub(/^Bearer\s+/i, "")
        unless token.present? && ActiveSupport::SecurityUtils.secure_compare(token, ENV["API_V2_TOKEN"].to_s)
          render json: { error: "unauthorized" }, status: :unauthorized and return
        end
      end

      # 方便子类调用
      def render_collection(collection, status: :ok)
        render json: collection, status: status
      end
    end
  end
end
