Rails.application.routes.draw do
  root 'posts#index'

  resources :posts do
    mount SuperbTextConstructor::Engine => '/wysiwyg'
  end

end
