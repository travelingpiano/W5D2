Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:create,:new,:show]
  resource :sessions, only: [:new,:destroy,:create]
  resources :bands, only: [:create,:index,:new,:edit,:update,:destroy,:show]
  resources :albums, except: [:index]
  resources :tracks, except: [:index]
end
