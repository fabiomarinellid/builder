Rails.application.routes.draw do

  namespace :backoffice do
    get 'dashboard', to: 'dashboard#index'
    get 'admins', to: 'admins#index'

    resources :admins, except: [:show]

  end
   
  devise_for :users, :skip => [:registrations]

  root 'backoffice/dashboard#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
