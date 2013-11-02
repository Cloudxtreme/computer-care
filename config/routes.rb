ComputerCare::Application.routes.draw do
    root to: "pages#home"
    get "send", to: "pages#contact_send"
    get "home", to: "pages#home"
    get "contact", to: "pages#contact"
    get "about", to: "pages#about"
    get "offers", to: "pages#offers"
    get "faq", to: "pages#faq"
    get "terms", to: "pages#terms"
    get "privacy", to: "pages#privacy"
    get "slider", to: "pages#slider"

  resources :sessions
  resources :tips
  resources :newsletter_users
  resources :student_codes
  resources :orders do
    resource :invoice do
      member do
        post :payment
      end
    end
    collection do
      post :finalize
      get :complete
    end
  end

    resources :services do
      collection do
        get :data_recovery
        get :replacement_parts
        get :virus_removal
        get :servicing
        get :upgrades
        get :repairs
      end

      member do
        get :quote
        post :quote_send
      end
    end
  resources :companies

  namespace :admin do
  	get "dashboard", to: "admin#dashboard"
      
      resources :tips
      resources :newsletter_users
      resources :student_codes
      resources :orders do
        resource :invoice
        member do
          post :update_cost
        end
      end
      resources :services do
        resources :service_options do
          resources :service_option_values
        end
      end
  end
end
