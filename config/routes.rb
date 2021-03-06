Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Always version the API
  namespace :v1 do
    resources :events, only: [:index], defaults: { format: :json }
    resources :purchases, only: [:create], defaults: { format: :json }
  end

end
