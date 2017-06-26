Rails.application.routes.draw do
  root 'game#new'

  get 'game/new'

  get 'game/search'

  post 'game/submit'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
