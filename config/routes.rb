Rails.application.routes.draw do


  # get 'doses/new'

  # get 'doses/create'
  root to: 'cocktails#index'
  # get 'doses/destroy'
  resources :cocktails, only: [:index, :show, :create, :new, :destroy] do
    resources :doses, only: [:new, :create, :destroy]
  end
end
