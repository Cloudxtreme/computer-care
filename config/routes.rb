MarketingSite::Application.routes.draw do
  root to: "pages#home"
  match "home", to: "pages#home"

  resources :companies
end
