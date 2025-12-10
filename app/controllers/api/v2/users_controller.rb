module Api
  module V2
    class UsersController < BaseController
      # 若要保护接口，请启用认证：
      # before_action :authenticate_by_token

      # GET /api/v2/users?page=1&per_page=20
      def index
        page = [ params[:page].to_i, 1 ].max
        per_page = [ [ params[:per_page].to_i, 1 ].max, 100 ].min
        users = FaDeusoddUser.select(:id, :serialno, :nickname, :truename, :phone, :openid)
                             .order(id: :desc)
                             .offset((page - 1) * per_page)
                             .limit(per_page)

        total = FaDeusoddUser.count
        groups_with_counts = FaDeusoddGroup
          .left_joins(:users)
          .group("#{FaDeusoddGroup.table_name}.id")
          .select("#{FaDeusoddGroup.table_name}.id, #{FaDeusoddGroup.table_name}.name, COUNT(#{FaDeusoddUser.table_name}.id) AS users_count")

        groups_payload = groups_with_counts.map do |g|
          {
            id: g.id,
            name: g.name,
            users_count: g.users_count.to_i
          }
        end

        render json: {
          data: users.as_json,
          meta: { page: page, per_page: per_page, total: total },
          groups: groups_payload
        }
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
