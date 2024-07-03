devise_for :users

get "profile", to: "users#show"
