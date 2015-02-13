PostitTemplate::Application.routes.draw do
  root to: 'posts#index'

  resources :posts, except: :destroy
  resources :categories, only: [:show, :new, :create] # no edit, update, destroy, or index 
end
