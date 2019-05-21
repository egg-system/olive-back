Rails.application.routes.draw do
  get 'dashboards/index'
  root to: 'dashboards#index'

  devise_for :staffs, only: :sessions, controllers: {
    sessions: 'staffs/sessions',
  }
  
  resources :shifts, only: [:index, :new, :create, :update]
  resources :stores, :staffs, :customers, :reservations do
    collection do
      post :search
    end
  end

  resources(
    :departments,
    :roles,
    :skills,
    :menu_categories,
    :menus,
    :options,
    :coupons, 
    :coupon_histories
  )

  namespace :api do
    devise_for :customers, skip: :all
    mount_devise_token_auth_for 'Customer', at: 'customers', controllers: {
      sessions: 'api/customers/sessions',
      registrations: 'api/customers/registrations',
      passwords: 'api/customers/passwords',
      token_validations: 'api/customers/token_validations',
    }
    get 'shops(/:id)', to: 'stores#shop'
    get 'shops(/:id)/menus', to: 'stores#menus'
    get 'shops(/:id)/dates', to: 'stores#dates'

    resources :reservations, only: [:create, :index, :show, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
