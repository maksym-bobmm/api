Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resource :items, only: [:create]
  end

  resource :tickets, only: %i[index show create]
  resource :excavators, only: [:create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
