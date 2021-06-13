Rails.application.routes.draw do
  resources :dashboards, :masters, only: [:index]
  root to: 'dashboards#index'

  devise_for :staffs, only: :sessions, controllers: {
    sessions: 'staffs/sessions',
  }

  resources :shifts, only: [:index, :new] do
    collection do
      patch :updates
    end
  end

  resources :csv_shifts, only: [:new, :create] do
    collection do
      post :save
      get :confirm
    end
  end

  namespace :customers do
    resources :duplicate
  end

  resources :customers do
    collection do
      post :search
    end

    member do
      # customerとmedical_recordsは一対一なのでGETとPOSTだけにする
      resources :medical_records, only: [:index, :create]
    end
  end
  
  resources :customer_integrations, only: [:show, :update]

  resources :stores, :staffs, :reservations do
    collection do
      post :search
    end
  end

  resources :taxes, only: :index do
    collection do
      post :toggle
    end
  end

  resources :observations, only: [:show, :new, :create, :update, :destroy]

  resources(
    :reservations,
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

    get 'taxes', to: 'taxes#index'

    namespace :admin do
      resources :staffs, only: [:index]
      resources :reservations, only: [:index]
      resources :shifts, only: [:index]
    end
  end
end
