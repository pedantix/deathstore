Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [] do
    resource :directives
  end
end
