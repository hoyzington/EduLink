Rails.application.routes.draw do

  root 'pages#home'
  get 'home', to: 'pages#home'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :teachers do
    get 'classes/new', to: 'klasses#new', as: 'klasses_new'
    get 'classes/:id/edit', to: 'klasses#edit', as: 'klasses_edit'
    get 'classes', to: 'klasses#index', as: 'klasses'
    get 'classes/:id', to: 'klasses#show', as: 'klass'
  end

resources :klasses, only: [:create, :update, :destroy]

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
