Rails.application.routes.draw do
  root 'welcome#home'

  resources :interviewees do
    resources :interviews, only: [:index]
end
  resources :interviewers do
      resources :interviews, only: [:new, :create, :index]
  end
  resources :interviews

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/auth/facebook/callback' => 'sessions#create_from_fb'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
