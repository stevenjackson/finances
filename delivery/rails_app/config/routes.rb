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
  resources :deposit
  get '/admin' => 'admin#index'
  post '/admin' => 'admin#save'

  get '/:month(/:year)' => 'dashboard#month'
  root to: 'dashboard#home'

end
