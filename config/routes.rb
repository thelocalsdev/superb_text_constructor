SuperbTextConstructor::Engine.routes.draw do
  root 'blocks#index'
  resources :blocks, except: [:index, :show] do
    post :reorder, on: :collection
  end
end
