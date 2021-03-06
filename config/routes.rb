Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'
  get "(page/:page)", to: "home#index"
  get 'provider/:slug', to: 'providers#show'
  get 'home/index', to: "home#index"

  get "/:id", to: 'states#show'
  get '(:id/page/:page)', to: 'states#show'
  get ':id/:zip_code', to: 'states#zip_codes',constraints: { zip_code: /\d{5}/}, via: :get
  get '(:id/:zip_code/page/:page)', to: 'states#zip_codes',constraints: { zip_code: /\d{5}/}, via: :get
  get ':id/:attribute', to: 'states#search'
  get '(:id/:attribute/page/:page)', to: 'states#search'
  get 'judicial/:state_id/:id', to: 'judicial_districts#show'
  get '(judicial/:state_id/:id/page/:page)', to: 'judicial_districts#show'

  concern :paginatable do
    get '(page/:page)', :action => :index, :on => :collection, :as => ''
  end

  resources :states, :concerns => :paginatable


  resources :judicial_districts

  get 'home/index'

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
