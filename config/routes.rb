G360EventApplication::Application.routes.draw do

    devise_for :users
    # The priority is based upon order of creation: first created -> highest priority.
    # See how all your routes lay out with "rake routes".

    # You can have the root of your site routed with "root"
    root to: redirect('/events')

    resources :assignments

    get '/assignments' => 'assignments#index', as: :user_management

    resources :locations
    resources :giveaways
    resources :event_giveaways

    resources :photos

    # Because viewing photos by tag is even better with a route for it 
    get 'photos/tags/:tag' => 'photos#index'

    
    resources :tags

    # Because viewing events by tag is even better with a route for it 
    get 'events/tags/:tag' => 'events#index'

    resources :events do
        shallow do
            resources :tags
            resources :comments
            resources :photos
            resources :event_giveaways
        end
    end


    resources :brands do
        shallow do
            resources :programs do
                resources :events
            end
        end
    end

    
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
