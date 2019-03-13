Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  
  root to: 'dashboards#index'
  get 'dashboards/index'
  
  resources :shifts, only: [:index, :new, :create, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
