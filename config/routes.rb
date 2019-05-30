# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }

  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end

    unauthenticated :user do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  concern :paginatable do
    get '(page/:page)', action: :index, on: :collection, as: ''
  end

  resources :accounts

  resources :billing_exports do
    member do
      get 'job_status'
      post 'perform'
    end
  end

  resources :clients, concerns: :paginatable do
    collection do
      get 'search'
    end
  end

  resources :invoices, concerns: :paginatable, only: [:index, :show] do
    collection do
      get 'download'
    end

    member do
      post 'perform_sync'
      get 'job_status'
    end
  end

  resources :technical_services, concerns: :paginatable do
    collection do
      get 'download'
    end
  end

  namespace :system do
    resources :groups, concerns: :paginatable
    resources :users, concerns: :paginatable
  end

  namespace :elements do
    resources :corporate_cellphones, concerns: :paginatable, except: [:show]
    resources :technicians, concerns: :paginatable, except: [:show]
    resources :work_types, concerns: :paginatable, except: [:show]
    resources :deposit_types, concerns: :paginatable, except: [:show]
    resources :telephone_types, concerns: :paginatable, except: [:show]
    resources :deposits, concerns: :paginatable, except: [:show] do
      collection do
        get 'search'
        get 'download'
        get 'move'
        get 'select' # Seleccionar si es un nuevo movimiento o uno en carga
        post 'move_detail'
        post 'create_move'
      end
    end
    resources :providers, concerns: :paginatable, except: [:show] do
      collection do
        get 'download'
        get 'search'
      end
    end
  end

  resources :moves, only: [:update, :edit, :index, :show] do
    collection do
      delete 'destroy_move_detail'
      get 'download'
    end
  end
  
  namespace :products do
    resources :categories, concerns: :paginatable, except: [:show]
    resources :product_types, concerns: :paginatable, except: [:show]
    resources :producers, concerns: :paginatable, except: [:show] do
      collection do
        get 'download'
      end
    end
    resources :products, concerns: :paginatable, except: [:show] do
      collection do
        get 'search'
        get 'download'
        get 'product_number_validator/:product_number', to: 'products#product_number_validator'
      end
    end
    resources :families, concerns: :paginatable, except: [:show]
  end
  namespace :taxes do
    resources :withholding_taxes, concerns: :paginatable, except: [:show]
    resources :voucher_types, concerns: :paginatable, except: [:show]
    resources :tax_categories, concerns: :paginatable, except: [:show] do
      collection do
        get 'search'
      end
    end

  end

  resources :inventories, concerns: :paginatable do
    collection do 
      get 'deposit_stock'
      get 'download_product'
      get 'per_deposit'
      get 'download_deposit_product'
    end
  end
end
