module Api
  module V2
    class HealthController < BaseController
      def show
        render json: { ok: true, env: Rails.env }, status: :ok
      end
    end
  end
end
