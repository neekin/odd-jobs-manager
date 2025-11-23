Rails.application.routes.draw do
  get "login" => "pages#login", as: :login
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root "spa#index"



  # 登录相关
  post "/sessions", to: "sessions#create"
  delete "/sessions", to: "sessions#destroy"
  get "/sessions/current", to: "sessions#current"

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # React SPA 入口：root 指向 SPA 页面（由 React Router 接管客户端路由）
  # 对其他符合条件的 HTML 请求，返回同一个 SPA 页面（排除静态资源与 Rails 管理的路径）
  get "*path", to: "spa#index", constraints: ->(req) {
    req.format.html? &&
      !req.path.match?(/\.(js|css|png|jpg|jpeg|svg|ico|map)$/) &&
      !req.path.start_with?("/rails") &&
      !req.path.start_with?("/assets") &&
      !req.path.start_with?("/packs")
  }
end
