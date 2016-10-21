Rails.application.routes.draw do
  root 'pages#index'

  namespace :api do
    resources :posts, only: [:index, :create, :destroy, :update]
  end
end
