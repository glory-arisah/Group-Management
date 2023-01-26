Rails.application.routes.draw do
  # get "welcome/index"
  devise_for :users

  authenticated :user do
    root "groups#index", as: :authenticated_root
  end

  root "welcome#index", as: :unauthenticated_root

  resources :groups
end
