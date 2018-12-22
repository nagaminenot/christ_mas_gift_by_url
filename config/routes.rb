Rails.application.routes.draw do
  root  'gifts#new'
  resources :gifts, except => :index
  get '/gifts/complete/:id', to: 'gifts#complete'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
