Rails.application.routes.draw do
  root to: 'static#index'

  get 'static/index'
  match 'oauth/callback', via: %i[get post] # for use with Github, Facebook
  get 'oauth/:provider', to: 'oauth#oauth', as: :auth_at_provider
  delete 'user_sessions/destroy', as: :logout


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
