Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'token', to: 'authentication#create'

      resources :pets, only: %i[index create show]
    end
  end

  resources '*unmatched', to: 'application#not_found'
end
