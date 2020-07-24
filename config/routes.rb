Rails.application.routes.draw do

  get 'classes/:class_id/quiz_grades/new', to: 'quiz_grades#new', as: :klass_quiz_grades_new
  # get 'quiz_grades/edit'
  resources :quiz_grades, only:[:create, :update, :destroy]


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

  get 'classes/:class_id/students/new', to: 'student_statuses#new', as: :klass_student_statuses_new
  get 'classes/:class_id/students/:id/edit', to: 'student_statuses#edit', as: :klass_student_statuses_edit
  get 'classes/:class_id/students', to: 'student_statuses#index', as: :klass_student_statuses
  get 'classes/:class_id/students/:id', to: 'student_statuses#show', as: :klass_student_status

  resources :student_statuses, only: [:create, :update, :destroy]

  get 'classes/:class_id/homework/new', to: 'homeworks#new', as: :klass_homeworks_new
  get 'classes/:class_id/homework/:id/edit', to: 'homeworks#edit', as: :klass_homeworks_edit
  get 'classes/:class_id/past_homework', to: 'homeworks#index_past', as: :klass_past_homeworks
  get 'classes/:class_id/future_homework', to: 'homeworks#index_future', as: :klass_future_homeworks
  get 'classes/:class_id/homework/:id', to: 'homeworks#show', as: :klass_homework

    resources :homeworks, only: [:create, :update, :destroy]

  get 'students/signup', to: 'students#new'
  post 'students/signup', to: 'students#create'
  resources :students do
    get 'statuses/:id', to: 'student_statuses#show', as: :student_status
    get 'past_homework', to: 'homeworks#index_past', as: :past_homeworks
    get 'classes', to: 'klasses#index', as: :klasses
  end

end
