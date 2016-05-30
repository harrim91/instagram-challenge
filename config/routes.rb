Rails.application.routes.draw do

  root 'pictures#index'
  get 'user/:id', to: 'users#show', as: 'user'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :pictures do
    resources :comments
  end
end
