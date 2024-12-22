get "profile", to: "users#show"

scope module: :users do
  resource :session
  resources :passwords, param: :token
end

resources :teams do
  get "delete", on: :member

  scope module: :teams do
    resources :invitations, only: %i[new create]
  end
end
