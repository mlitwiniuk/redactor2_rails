Redactor3Rails::Engine.routes.draw do
  resources :images, only: :create do
    get :list, on: :collection
  end
  resources :files, only: :create
end
