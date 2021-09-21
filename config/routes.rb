Rails.application.routes.draw do
  post '/deck', to: 'decks#new'
  get '/deck', to: 'decks#previous'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
