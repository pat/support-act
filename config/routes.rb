# frozen_string_literal: true

Rails.application.routes.draw do
  resources :authentications, :only => :new
  resources :sessions, :only => :new

  get "/purchases/:fan_uuid/:album_uuid" => "purchases#create", :as => :purchase

  root :to => "home#index"
end
