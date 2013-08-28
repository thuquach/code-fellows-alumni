Alumni::Application.routes.draw do
scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  root :to => 'main#index'
  resources :users do
    resources :links
  end
  resources :users do
    collection { post :search, to: 'users#index' }
  end
  resources :projects do
    resources :links
  end
  resources :links
  resources :addresses
  get 'remote%2FgetStates%2F:country', to:'addresses#getStates'
  resources :users do
    resources :inquiries, :only => [:new, :create] do
      get 'thank_you', :on => :collection
    end
  end
end
match '*path', to: redirect("/#{I18n.locale}/%{path}"), constraints: lambda { |req| !req.path.starts_with? "/#{I18n.locale}/" }
match '', to: redirect("/#{I18n.locale}")

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
