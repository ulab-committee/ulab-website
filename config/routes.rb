# frozen_string_literal: true

Rails.application.routes.draw do
  mount Spina::Engine => '/'

  # manual redirecting of old routes
  get '/issues/1', to: redirect('/volumes/1/issues/1')
  get '/issues/1/articles/1', to: redirect('/volumes/1/issues/1/articles/1')
  get '/issues/1/articles/2', to: redirect('/volumes/1/issues/1/articles/2')
  get '/issues/1/articles/3', to: redirect('/volumes/1/issues/1/articles/3')
end
