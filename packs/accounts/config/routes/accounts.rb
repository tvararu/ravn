devise_for :users, controllers: {
                     # confirmations: "users/confirmations",
                     # omniauth_callbacks: "users/omniauth_callbacks",
                     # unlocks: "users/unlocks",
                     passwords: "users/passwords",
                     registrations: "users/registrations",
                     sessions: "users/sessions",
                   }

get "profile", to: "users#show"

resources :teams do
  get "delete", on: :member
end
