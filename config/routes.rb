Rails.application.routes.draw do
  devise_for :users
  root "blog#index"
  get "blog/index"
  get "blog/index/:cat", to: 'blog#index'
  get "blog/show/:id", to: 'blog#show'
  get "blog/new"
  post "blog/create"
  get "blog/edit/:id", to: 'blog#edit'
  post "blog/update/:id", to: 'blog#update'
  post "blog/destroy/:id", to: 'blog#destroy'
  
  get "blog/diary"
  post "blog/write_diary"
  post "blog/destroy_diary/:diary_id", to: 'blog#destroy_diary'
  

  resources :sitemaps, :only => :show
  get "sitemap" => "sitemaps#show"
  # get "sitemap.xml" => "sitemaps#show", format: "xml", as: :sitemap
  get "google94359cbfebea9a3b" => "sitemaps#google"
  
  
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
