BonusEngine::Engine.routes.draw do
  namespace :api do
    namespace :admin do
      resources :cycles do
        resources :events
      end

      resources :users, only: [:index, :show]
    end

    resources :cycles, only: [:index, :show] do
      resources :events, only: [:index, :show] do
        resources :points
      end
      resources :users, only: [:index, :show]
    end
  end

  namespace :admin do
    match 'bonus', to: 'bonus#index', via: :get
  end

  resources :bonus, only: :index
  get 'cycles/:cycle_id/events', to: 'bonus#index'
  get 'cycles/:cycle_id/events/:id', to: 'bonus#index'
end

