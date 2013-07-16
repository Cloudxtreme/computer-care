MarketingSite::Application.routes.draw do
  root to: "pages#home"
  match "home", to: "pages#home"
  match "services", to: "pages#services"
  match "contact", to: "pages#contact"
  match "about", to: "pages#about"
  match "offers", to: "pages#offers"
  match "faq", to: "pages#faq"
  match "terms", to: "pages#terms"
  resources :companies
end
