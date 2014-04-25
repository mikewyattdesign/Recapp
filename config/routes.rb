require 'api_constraints'

G360EventApplication::Application.routes.draw do
    devise_for :users

    root to: redirect('/events')

    resources :assignments

    patch 'update_role' => 'assignments#update_role', as: :update_role
    get '/assignments' => 'assignments#index', as: :user_management
    delete '/assignments' => 'assignments#destroy'

    resources :locations
    resources :giveaways
    resources :event_giveaways

    resources :photos
    resources :videos
    resources :documents

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
            resources :videos
            resources :documents
        end
    end

    resources :brands do
        shallow do
            resources :programs do
                resources :events
            end
        end
    end

    get '/help' => 'static#index', as: :help

    namespace :api, defaults: { format: 'json' } do
        scope module: :v1, constraints: ApiConstraints.new(version: 1) do
            get 'photos/tags/:tag' => 'photos#tags'
        end
    end
end
