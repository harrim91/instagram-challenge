Rails.application.routes.draw do

  root 'pictures#index'
  get 'user/:id', to: 'users#show', as: 'user'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :pictures do
    resources :comments
    member do
      post "like", to: "votes#like"
      delete "unlike", to: "votes#unlike"
    end
  end
end
