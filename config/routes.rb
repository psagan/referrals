Referrals::Engine.routes.draw do
  root 'dashboard#index'
  resources :income_history, only: [:index] do
    post :filter, on: :collection
  end
  resources :withdrawal, only: [:index, :new, :create] do
    post :filter, on: :collection
  end
  resources :admin_withdrawal, only: [:index] do
    post :filter, on: :collection
  end
end
