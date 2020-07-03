Rails.application.routes.draw do

  root 'pages#home'
  get 'home', to: 'pages#home'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :teachers do
    get 'classes/new', to: 'klasses#new', as: :klasses_new
    get 'classes/:id/edit', to: 'klasses#edit', as: :klasses_edit
    get 'classes', to: 'klasses#index', as: :klasses
    get 'classes/:id', to: 'klasses#show', as: :klass
  end

  resources :klasses, only: [:create, :update, :destroy]

  get 'classes/:class_id/student_statuses/new', to: 'student_statuses#new', as: :klass_student_statuses_new
  # get 'classes/class_id/student_statuses/:id/edit', to: 'student_statuses#edit', as: :klass_student_statuses_edit
  # get 'classes/class_id/student_statuses', to: 'student_statuses#index', as: :klass_student_statuses
  # get 'classes/class_id/student_statuses/:id', to: 'student_statuses#show', as: :klass_student_status

  resources :student_statuses, only: [:create, :update, :destroy]

  # get 'classes/class_id/homework/new', to: 'homeworks#new', as: :klass_homeworks_new
  # get 'classes/class_id/homework/:id/edit', to: 'homeworks#edit', as: :klass_homeworks_edit
  # get 'classes/class_id/homework', to: 'homeworks#index', as: :klass_homeworks
  # get 'classes/class_id/homework/:id', to: 'homeworks#show', as: :klass_homework

    resources :homeworks, only: [:create, :update, :destroy]

  
  # get 'students/signup', to: 'students#new'
  # resources :students do
  #   get 'student_status/:id', to: 'student_statuses#show'
  #   get 'homework', to: 'homeworks#index'
  # end

end
