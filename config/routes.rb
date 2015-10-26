Rails.application.routes.draw do
  resources :users, only: [:index, :new, :create] do
    resources :goals, only: [:index]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :goals, except: [:index]
end
