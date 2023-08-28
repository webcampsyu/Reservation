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
    post '/reservatins/new', to: 'reservations#teacher_new'
    get '/reservations/all_day_new', to: 'reservations#all_day_new'
    get '/reservations/:id', to: 'reservations#teacher_show'
    delete '/temp_reservation/:id', to: 'temp_reservations#teacher_destroy', as: :destroy_temp_reservation
  end
  delete '/reservations/:id', to: 'reservations#teacher_destroy', as: :destroy_reservation
  resources :users do
    resources :teachers do
      resources :temp_reservations
    end
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
