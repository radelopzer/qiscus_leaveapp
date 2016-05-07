Rails.application.routes.draw do

  root 'sessions#new'

    get '/login' => 'sessions#new'
    post '/login' => 'sessions#create'
    get '/logout' => 'sessions#destroy'

  get '/profile_settings'          =>'users#profile_setting'
  get '/create_messages'          =>'messages#new'
  get '/create_employee_account'  =>'users#new'
  get '/list_messages_approved' =>'static_pages#list_messages_approved'
  get '/list_messages_rejected' =>'static_pages#list_messages_rejected'
  get 'list_messages'       =>'messages#index'
  get '/list_employee'      =>'users#index'
  get 'resubmit_message'      =>'message#resubmit_message'
  get '/dashboard'      =>'static_pages#index'
  get '/delete'         =>'messages#index'
  post '/approve'       =>'messages#approve'
  # These routes will be for signup. The first renders a form in the browse, the second will 
  # receive the form and create a user in our database using the data given to us by the user.
  get '/signup'         =>'users#new'
  post'/users'          =>'users#create'

  get 'users/show'
  

  resources :sessions
  resources :users
  resources :messages

end
