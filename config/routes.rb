Rails.application.routes.draw do
  scope via: :all do
    get "/404", to: "errors#not_found"
    get "/422", to: "errors#unprocessable_entity"
    get "/429", to: "errors#too_many_requests"
    get "/500", to: "errors#internal_server_error"
  end

  draw :accounts

  authenticate :user, ->(user) { user.admin? } do
    mount Avo::Engine, at: Avo.configuration.root_path
    mount MissionControl::Jobs::Engine, at: "/jobs"
  end

  root to: "pages#home"
  get "up", to: "rails/health#show", as: :rails_health_check
end
