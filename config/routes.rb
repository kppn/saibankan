Rails.application.routes.draw do

  root :to => 'tops#index'

  devise_for :users, :controllers => {
    :sessions      => "devise_custom/sessions",
    :registrations => "devise_custom/registrations",
    :passwords     => "devise_custom/passwords",
  }

  namespace :users do
    #get 'users/home'     => 'users#home'
    get 'home'
    resources :affiliations, only: [:create, :edit, :destroy]
  end

  resources :markings, only: [:create]
  resources :marks, only: [:index, :new, :show, :edit, :create, :destroy]

  resources :projects do
    # resources :allocations # no use for user input
    resources :numbers, only: [:index, :create], shallow: true
    resources :number_formats do
      resources :number_parts
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
