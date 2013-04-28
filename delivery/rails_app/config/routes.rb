RailsApp::Application.routes.draw do
  resources :transaction do
    collection do
      put 'assign'
    end
    member do
      get 'split'
      put 'save_splits'
    end
  end
  root to: 'dashboard#home'

end
