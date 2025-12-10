module Api
  module V2
    class GroupsController < BaseController
      # 若要保护接口，请启用认证：
      # before_action :authenticate_by_token

      # GET /api/v2/users?page=1&per_page=20
      def index
        groups = FaDeusoddGroup.where(status: "normal").order(weigh: :desc, id: :desc)
        list = groups.map { |g| g.as_json(only: [ :id, :name, :count_office, :count_resign ]) }
        list << { "id" => 0, "name" => I18n.t("non_group", default: "Non Group") }
        render json: { searchlist: list }
      end

      # GET /api/v2/users/:id
      def show
        user = FaDeusoddUser.find_by(id: params[:id])
        return render json: ({ error: "not_found" }), status: :not_found unless user

        render json: { data: user.as_json(only: [ :id, :serialno, :nickname, :truename, :phone, :openid ]) }
      end
    end
  end
end
