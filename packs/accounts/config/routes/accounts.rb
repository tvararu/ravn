get "profile", to: "users#show"

resources :teams do
  get "delete", on: :member

  scope module: :teams do
    resources :invitations, only: %i[new create]
  end
end
