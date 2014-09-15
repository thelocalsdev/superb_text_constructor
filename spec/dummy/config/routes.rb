Rails.application.routes.draw do
  root 'posts#index'
  resources :posts
  superb_text_constructor_for :posts
end
