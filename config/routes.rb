Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root "groups#index", as: :authenticated_root
  end

  root "welcome#index", as: :unauthenticated_root

  resources :groups do
    resources :user_groups, only: %i[destroy create]
  end
  get "/groups/:id/manage", to: "groups#manage"
  get "/groups/:id/view_members", to: "groups#view_members"
end
