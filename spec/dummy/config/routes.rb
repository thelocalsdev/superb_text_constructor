Rails.application.routes.draw do
  root 'posts#index'

  resources :posts do
    mount SuperbWysiwyg::Engine => '/wysiwyg'
  end

end
