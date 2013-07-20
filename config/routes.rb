MarketingSite::Application.routes.draw do
  root to: "pages#home"
  match "home", to: "pages#home"
  match "contact", to: "pages#contact"
  match "about", to: "pages#about"
  match "offers", to: "pages#offers"
  match "faq", to: "pages#faq"
  match "terms", to: "pages#terms"

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
  end
end
