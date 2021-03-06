BonusEngine::Engine.routes.draw do
  namespace :api do
    namespace :admin do
      resources :cycles do
        resources :events
      end

      resources :events do
        resources :reports, only: :index
      end

      resources :users, only: [:index, :show]
    end

    resources :cycles, only: [:index, :show] do
      resources :events, only: [:index, :show] do
        resources :points
      end
      get 'users/me', to: 'users#me'
      resources :users, only: [:index, :show]
    end
    resources :events do
      resources :points, only: [:create, :update]
      resources :reports, only: [:index]
    end
  end

  namespace :admin do
    match 'bonus', to: 'bonus#index', via: :get
    match 'bonus/cycles/:cycle_id/events/new', to: 'bonus#index', via: :get
    match 'bonus/cycles/:cycle_id/edit', to: 'bonus#index', via: :get
  end

  resources :bonus, only: :index
  get 'cycles/:cycle_id/events', to: 'bonus#index'
  get 'cycles/:cycle_id/events/:id', to: 'bonus#index', as: 'cycle_event'
  get 'cycles/:cycle_id/events/:id/me', to: 'bonus#index'
  get 'cycles/:cycle_id/events/:event_id/users/:id', to: 'bonus#index'
end

