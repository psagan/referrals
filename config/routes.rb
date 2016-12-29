Referrals::Engine.routes.draw do
  root 'dashboard#index'
  resources :income_history, only: [:index] do
    post :filter, on: :collection
  end
end
