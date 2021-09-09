Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'token', to: 'authentication#create'

      resources :pets, only: [:index]
    end
  end
end
