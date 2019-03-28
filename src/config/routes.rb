Rails.application.routes.draw do
  
  resources :customers, only: [:index, :show, :create, :update, :new] do
    collection do
      post :search
    end
  end
  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    passwords: 'customers/passwords',
    registrations: 'customers/registrations'
  }

  
  devise_for :staffs, controllers: {
    sessions: 'staffs/sessions'
  }
  resources :staffs, only: [:index, :show, :create, :update, :new] do
    collection do
      post :search
    end
  end
  
  root to: 'dashboards#index'
  get 'dashboards/index'
  
  resources :shifts, only: [:index, :new, :create, :update]

  namespace :api do 
    resources :stores, path: :shops, only: [:show]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
