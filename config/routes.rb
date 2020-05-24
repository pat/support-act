# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :fans

  namespace :last_fm do
    resource :connection, :only => %i[ new show ]
  end

  get "/purchases/:fan_uuid/:album_uuid" => "purchases#create", :as => :purchase

  root :to => "home#index"
end
