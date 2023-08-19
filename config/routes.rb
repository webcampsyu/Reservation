Rails.application.routes.draw do
  devise_for :teachers, controllers: {
    sessions: 'teachers/sessions',
    registrations: 'teachers/registrations'
  }
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  
  resources :users do 
    resources :teachers do 
      resources :reservations
    end 
    get '/choice', to: 'reservations#choice'
  end 
  resources :teachers do
    get '/reservations/index', to: 'reservations#teacher_index'
    post '/reservations/index', to: 'reservations#teacher_create'
    get '/reservations/new,', to: 'reservations#techer_new'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
