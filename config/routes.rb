require 'api_constraints'

G360EventApplication::Application.routes.draw do
    devise_for :users

    root to: redirect('/brands')

    resources :assignments

    patch 'update_role' => 'assignments#update_role', as: :update_role
    get '/assignments' => 'assignments#index', as: :user_management
    delete '/assignments' => 'assignments#destroy'

    resources :users
    resources :locations
    resources :giveaways
    resources :event_giveaways
    resources :comments
    resources :videos
    resources :documents
    resources :contacts

    get 'photos/:photo_id/comments', to: redirect('photos/%{photo_id}')

    resources :photos do
        shallow do
            resources :comments
        end
    end

    post 'photos/:id/favorite' => 'photos#favorite', as: :favorite_photo

    # Because viewing photos by tag is even better with a route for it
    get 'photos/tags/:tag' => 'photos#index', as: :tag_photos

    get 'photos/programs/:program_id' => 'photos#index', as: :program_photos

    get 'photos/brands/:brand_id' => 'photos#index', as: :brand_photos

    post 'photos/s3-upload-complete' => 'photos#s3_upload_complete', as: :s3_upload_complete

    resources :tags

    # Because viewing events by tag is even better with a route for it
    get 'events/tags/:tag' => 'events#index'

    resources :events do
        shallow do
            resources :tags
            resources :comments
            resources :photos
            resources :event_giveaways
            resources :videos
            resources :documents
        end
    end

    get 'events/:id/approve' => 'events#approve', as: 'event_approval'
    get 'programs/:id/approve' => 'programs#approve', as: 'program_approval'

    get 'events/:id/photos/favorite_order' => 'photos#favorite_order', as: :favorite_order_photos
    post 'events/:id/photos/set_favorite_photo_order' => 'photos#set_favorite_order'

    resources :brands do
        shallow do
            resources :programs do
                resources :events
            end
        end
    end

    get 'brands/:brand_id/giveaways' => 'giveaways#index', as: :brand_giveaways
    get 'brands/:brand_id/comments' => 'comments#index', as: :brand_comments

    get 'programs/:program_id/comments' => 'comments#index', as: :program_comments

    get '/help' => 'static#index', as: :help

    namespace :api, defaults: { format: 'json' } do
        scope module: :v1, constraints: ApiConstraints.new(version: 1) do
            get 'photos/tags/:tag' => 'photos#tags'
        end
    end
end
