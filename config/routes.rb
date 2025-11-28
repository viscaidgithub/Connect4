Rails.application.routes.draw do
  root "games#index"
  resources :games, only: [:index, :show, :create] do
    member do
      post :move   # POST /games/:id/move   params: col
      post :reset  # POST /games/:id/reset
    end
  end

  post :clear, to: 'games#clear'
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
