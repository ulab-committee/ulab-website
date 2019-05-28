# frozen_string_literal: true

require 'resque/server'

Rails.application.routes.draw do
  mount Spina::Engine => '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  Spina::Engine.routes.draw do
    # namespace :conferences, path: 'calendars' do
    #   resources :presentations, only: :index
    #   resources :conferences, only: %i[index show] do
    #     resources :presentations, only: :index
    #   end
    # end
    namespace :admin, path: Spina.config.backend_path do
      mount Resque::Server, at: '/jobs'
    end
  end
end
