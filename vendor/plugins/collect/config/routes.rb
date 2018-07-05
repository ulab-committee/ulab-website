Spina::Engine.routes.draw do
  namespace :admin, path: Spina.config.backend_path do
    resources :presentations, except: [:show]
  end

  namespace :collect do
    resources :presentations, only: [:index, :show]
  end
end
