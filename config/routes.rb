Rails.application.routes.draw do
  match '/' => redirect('/users'), via: :all
  get  '/users',    to: 'users#index'
  post '/users',    to: 'users#login'
  get '/logout',    to: 'users#logout'
  get  '/contents', to: 'contents#index'
  post '/contents', to: 'contents#update'

  match '*path' => redirect('/users'), via: :all
end
