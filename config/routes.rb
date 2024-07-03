Rails.application.routes.draw do
  draw :accounts

  root to: "pages#home"
  get "up", to: "rails/health#show", as: :rails_health_check
end
