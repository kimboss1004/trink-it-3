Rails.application.routes.draw do

  root to: "colleges#index"

  # get "/inbox", to: "inboxes#inbox"


  get "/register", to: "users#new"
  resources :users, only: [:create] do
    member do
      get 'join_college', to: "users#get_join_college"
      patch 'save_college', to: "users#join_college"
    end
  end

  get "/sign_in", to: "sessions#new"
  delete "/sign_out", to: 'sessions#destroy'
  resources :sessions, only: [:create] 

  get 'auth/:provider/callback', to: 'sessions#facebook_create'
  get 'auth/failure', to: redirect('/')

  resources :colleges, path: '/', only: [:show] do
    resources :users, only: [:edit, :update] do
      get '/my-books', to: 'books#my_books'
      get "/inbox", to: "messages#inbox"
      get "thread/:id", to: "messages#thread", as: 'thread'
      
    end
    resources :categories, only: [:show]
    
    resources :books do
      member do
        post 'message', to: 'messages#create'
      end
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
