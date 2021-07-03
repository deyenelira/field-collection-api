Rails.application.routes.draw do
  resources :answers
  resources :questions
  resources :formularies
  resources :visits
  resources :users
  post 'authenticate', to: 'authentication#authenticate'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
