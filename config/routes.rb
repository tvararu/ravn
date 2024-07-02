Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"

  get "up", to: "rails/health#show", as: :rails_health_check

  get "profile", to: "users#show"
end
