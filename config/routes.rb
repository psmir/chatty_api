Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post :operation, to: 'main#operation'

  mount ActionCable.server, at: '/cable'
end
