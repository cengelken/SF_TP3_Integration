Rails.application.routes.draw do

  root 'case_sets#index'
  resources :case_sets do
    resources :cases do
      resources :tasks
    end
  end
  match 'auth/:provider/callback', to: 'sessions#create', as: 'signin', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
end
