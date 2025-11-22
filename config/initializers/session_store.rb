Rails.application.config.session_store :cookie_store,
  key: "_odd_jobs_manager_session",
  same_site: :lax,                      # 同源场景推荐 :lax
  secure: Rails.env.production?         # 生产环境下强制 https
