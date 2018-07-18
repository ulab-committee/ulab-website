Spina::Engine.routes.draw do
  namespace :admin, path: Spina.config.backend_path do
    resources :conferences, except: [:show]
    resources :delegates, except: [:show]
    resources :presentations, except: [:show] do
      member do
        get 'conference_dates'
      end
    end
  end

  namespace :collect do
    resources :presentations, only: [:index, :show]
  end
end
