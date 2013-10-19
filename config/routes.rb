ComputerCare::Application.routes.draw do
    root to: "pages#home"
    match "send", to: "pages#contact_send"
    match "home", to: "pages#home"
    match "contact", to: "pages#contact"
    match "about", to: "pages#about"
    match "offers", to: "pages#offers"
    match "faq", to: "pages#faq"
    match "terms", to: "pages#terms"
    match "privacy", to: "pages#privacy"
    match "slider", to: "pages#slider"

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
  	match "dashboard", to: "admin#dashboard"
      
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
