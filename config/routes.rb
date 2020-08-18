Rails.application.routes.draw do
  get 'users/show'
  devise_for :users, controllers: {
        sessions:      'users/sessions',
        passwords:     'users/passwords',
        registrations: 'users/registrations'
    }
  root :to => "homes#top"
  get 'home/about' =>'homes#about'
  get 'home/search' =>'homes#search'

  resources :posts do
    get :search, on: :collection
    resources :favorites , only: [:create , :destroy, :index]
  end

  resources :users do
  end

  resources :posts do
      resources :favorites , only: [:create , :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
