Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, path: :organizations, only: [:show, :new, :create, :edit], as: 'organizations'
  resources :users, path: :developers, only: [:show, :new, :create, :edit], as: 'developers'
end
