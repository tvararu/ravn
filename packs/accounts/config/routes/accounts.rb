devise_for :users, controllers: {
                     # unlocks: "users/unlocks",
                     confirmations: "users/confirmations",
                     invitations: "users/invitations",
                     omniauth_callbacks: "users/omniauth_callbacks",
                     passwords: "users/passwords",
                     registrations: "users/registrations",
                     sessions: "users/sessions",
                   }

get "profile", to: "users#show"

resources :teams do
  get "delete", on: :member

  scope module: :teams do
    resources :invitations, only: %i[new create]
  end
end
