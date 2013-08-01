MarketingSite::Application.routes.draw do
  root to: "pages#home"
  match "send", to: "pages#contact_send"
  match "home", to: "pages#home"
  match "contact", to: "pages#contact"
  match "about", to: "pages#about"
  match "offers", to: "pages#offers"
  match "faq", to: "pages#faq"
  match "terms", to: "pages#terms"
  match "slider", to: "pages#slider"

  resources :newsletter_users

  resources :services do
    collection do
      get :data_recovery
      get :replacement_parts
      get :virus_removal
      get :servicing
      get :upgrades
      get :repairs
    end
  end
  resources :companies

  namespace :admin do
  	match "dashboard", to: "admin#dashboard"
      resources :newsletter_users
  end
end
