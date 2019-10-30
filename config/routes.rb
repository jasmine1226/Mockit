Rails.application.routes.draw do
  resources :interviews
  resources :interviewees
  resources :interviewers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
