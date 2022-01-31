# frozen_string_literal: true

Rails.application.routes.draw do
  # manual redirecting of old routes
  get '/journal/issues/1', to: redirect('/journal/volumes/1/issues/1')
  get '/journal/issues/1/articles/1', to: redirect('/journal/volumes/1/issues/1/articles/1')
  get '/journal/issues/1/articles/2', to: redirect('/journal/volumes/1/issues/1/articles/2')
  get '/journal/issues/1/articles/3', to: redirect('/journal/volumes/1/issues/1/articles/3')
  get '/journal/issues/1/articles/1.pdf', to: redirect('/journal/volumes/1/issues/1/articles/1.pdf')
  get '/journal/issues/1/articles/2.pdf', to: redirect('/journal/volumes/1/issues/1/articles/2.pdf')
  get '/journal/issues/1/articles/3.pdf', to: redirect('/journal/volumes/1/issues/1/articles/3.pdf')

  mount Spina::Engine => '/'
end
