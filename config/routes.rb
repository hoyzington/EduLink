Rails.application.routes.draw do

  root 'pages#home'
  get 'home', to: 'pages#home'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get '/auth/facebook/callback', to: 'sessions#omniauth'
  delete 'logout', to: 'sessions#destroy'

  get 'teachers/signup', to: 'teachers#new'

  resources :teachers do
    get 'classes/new', to: 'klasses#new', as: :klasses_new
    get 'classes/:id/edit', to: 'klasses#edit', as: :klasses_edit
    get 'classes', to: 'klasses#index', as: :klasses
    get 'classes/:id', to: 'klasses#show', as: :klass
    get 'end_of_year_proceedure', to: 'klasses#year_end', as: :end_of_year
    post 'destroy_data', to: 'klasses#destroy_data', as: :destroy_data
  end

  # handles back button edge case
  get '/klasses', to: 'klasses#new'

  resources :klasses, only: [:create, :update, :destroy]

  get 'classes/:klass_id/students/new', to: 'student_statuses#new', as: :klass_student_statuses_new
  get 'classes/:klass_id/students/:id/edit', to: 'student_statuses#edit', as: :klass_student_statuses_edit
  get 'classes/:klass_id/students', to: 'student_statuses#index', as: :klass_student_statuses
  get 'classes/:klass_id/non_edulink_students', to: 'student_statuses#non_edulink_students', as: :klass_non_edulink
  get 'classes/:klass_id/students/:id', to: 'student_statuses#show', as: :klass_student_status

  get '/student_statuses', to: 'student_statuses#new'

  resources :student_statuses, only: [:create, :update, :destroy]

  get 'classes/:klass_id/homework/new', to: 'homeworks#new', as: :klass_homeworks_new
  get 'classes/:klass_id/homework/:id/edit', to: 'homeworks#edit', as: :klass_homeworks_edit
  get 'classes/:klass_id/past_homework', to: 'homeworks#index_past', as: :klass_past_homeworks
  get 'classes/:klass_id/future_homework', to: 'homeworks#index_future', as: :klass_future_homeworks
  get 'classes/:klass_id/late_homework', to: 'homeworks#index_late', as: :klass_late_homeworks
  get 'classes/:klass_id/homework/:id', to: 'homeworks#show', as: :klass_homework

  get '/homeworks', to: 'homeworks#new'

  resources :homeworks, only: [:create, :update, :destroy]

  get 'classes/:klass_id/quiz_grades/new', to: 'quiz_grades#new', as: :klass_quiz_grades_new
  get 'classes/:klass_id/quiz_grades/:id/edit', to: 'quiz_grades#edit', as: :klass_quiz_grades_edit

  get '/quiz_grades', to: 'quiz_grades#new'

  resources :quiz_grades, only:[:create, :update, :destroy]

  get 'students/signup', to: 'students#new'

  resources :students, except:[:new] do
    get 'statuses/:id', to: 'student_statuses#show', as: :student_status
    get 'past_homework', to: 'homeworks#index_past', as: :past_homeworks
    get 'classes', to: 'klasses#index', as: :klasses
    get 'finish_profile', to: 'students#finish_profile'
  end

end
