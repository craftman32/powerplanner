Rails.application.routes.draw do
  # Setting the routes for Lucy
  get 'lucy/start'

  get 'lucy/weaknesses'
  get 'lucy/autoweaknesses'
  post 'lucy/weaknesses_post'

  get 'lucy/timeframe'
  post 'lucy/timeframe_post'

  get 'lucy/equipment'
  get 'lucy/commercialequipment'
  get 'lucy/powerliftingequipment'

  get 'lucy/maxeffort'
  get 'lucy/automaxeffort'
  post 'lucy/maxeffort_post'

  get 'lucy/dynamiceffort'
  get 'lucy/autodynamiceffort'
  post 'lucy/dynamiceffort_post'

  get 'lucy/repetitioneffort'
  get 'lucy/autorepetitioneffort'
  post 'lucy/repetitioneffort_post'

  get 'lucy/warmup'
  get 'lucy/autowarmup'
  post 'lucy/warmup_post'

  get 'lucy/deload'
  get 'lucy/autodeload'
  post 'lucy/deload_post'

  get 'lucy/finish'
  get 'lucy/about'

  devise_for :users
  get 'welcome/index'
  get 'welcome/about'
  get 'macrocycles/editexercises'
  post 'macrocycles/editexercises_post'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  resources :exercises do
    get 'index'
    get 'show'
  end
  resources :macrocycles
  
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
