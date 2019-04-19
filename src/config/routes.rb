Rails.application.routes.draw do
  get 'dashboards/index'
  root to: 'dashboards#index'

  devise_for :staffs, only: :sessions, controllers: {
    sessions: 'staffs/sessions',
  }
  resources :staffs, only: [:index, :show, :create, :update, :new] do
    collection do
      post :search
    end
  end

  resources :customers, only: [:index, :show, :create, :update, :new] do
    collection do
      post :search
    end
  end

  resources :shifts, only: [:index, :new, :create, :update]
  resources :departments, :roles
  resources :skills, :menu_categories, :menus
  resources :coupons, :coupon_histories

  resources :stores do
    collection do
      post :search
    end
  end
  
  namespace :api do
    devise_for :customers, skip: :all
    mount_devise_token_auth_for 'Customer', at: 'customers', controllers: {
      sessions: 'api/customers/sessions'
    }
    get 'shops(/:id)', to: 'stores#shop'
    get 'shops(/:id)/menus', to: 'stores#menus'
    get 'shops(/:id)/dates', to: 'stores#dates'
    post 'reserve/commit', to: 'reservations#commit'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
