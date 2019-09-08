Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get :query, to: 'main#query'
  post :mutation, to: 'main#mutation'

  mount ActionCable.server, at: '/cable'
end
