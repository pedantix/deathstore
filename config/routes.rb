Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [] do
    resource :directives do
      get :qr_code, on: :collection
    end
  end
end
