RailsApp::Application.routes.draw do
  resources :transaction
  root to: 'dashboard#home'

end
