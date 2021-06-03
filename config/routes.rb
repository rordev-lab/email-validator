Rails.application.routes.draw do
  root 'email_validators#index'

  resources :email_validators, only: %i[index create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
