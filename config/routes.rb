Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token

  scope via: :all do
    get "/404", to: "errors#not_found"
    get "/406", to: "errors#not_acceptable"
    get "/422", to: "errors#unprocessable_entity"
    get "/429", to: "errors#too_many_requests"
    get "/500", to: "errors#internal_server_error"
  end

  draw :accounts
  draw :admin

  root to: "pages#home"
  get "up", to: "rails/health#show", as: :rails_health_check
end
