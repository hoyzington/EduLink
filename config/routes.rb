Rails.application.routes.draw do

  root 'pages#home'
  get 'home', to: 'pages#home'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :teachers do
    get 'classes/new', to: 'klasses#new'
    get 'classes/:id/edit', to: 'klasses#edit'
    get 'classes', to: 'klasses#index'
    get 'classes/:id', to: 'klasses#show'
    resources :klasses
  end

  get 'classes/:id', to: 'klasses#show' do
    resources :student_statuses
    get 'homework/new', to: 'homeworks#new'
    get 'homework/:id/edit', to: 'homeworks#edit'
    get 'homework', to: 'homeworks#index'
    get 'homework/:id', to: 'homeworks#show'
    resources :homeworks
  end
  
  get 'students/signup', to: 'students#new'
  resources :students do
    get 'student_status/:id', to: 'student_statuses#show'
    get 'homework', to: 'homeworks#index'
  end

end
