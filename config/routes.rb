Rails.application.routes.draw do
  get  '/users',    to: 'users#index'
  post '/users',    to: 'users#login'
  get  '/contents', to: 'contents#index'
  post '/contents', to: 'contents#update'
end
