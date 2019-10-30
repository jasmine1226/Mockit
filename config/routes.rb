Rails.application.routes.draw do
  resources :interviews, except: [:index]
  resources :interviewees, except: [:index]
  resources :interviewers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
