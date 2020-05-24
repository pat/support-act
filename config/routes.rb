# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :fans

  namespace :last_fm do
    resource :connection, :only => %i[ new show ]
  end

  namespace :my do
    resource :dashboard, :only => :show

    get "/purchases/:fan_uuid/:album_uuid" => "purchases#create", :as => :purchase
  end

  root :to => "home#index"
end
