Spina::Engine.routes.draw do
  namespace :admin, path: Spina.config.backend_path do
    resources :presentations, except: [:show]
  end
  namespace :collect do
    root to: 'presentations#index'
    get ':id', to: 'presentations#show', as: :presentations
  end
end
