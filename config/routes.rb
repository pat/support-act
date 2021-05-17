# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :fans, :controllers => {:sessions => "sessions"}

  namespace :last_fm do
    resource :connection, :only => %i[ new show destroy ]
  end

  get "/auth/spotify/callback", :to => "spotify/connections#create"

  namespace :spotify do
    resource :connection, :only => %i[ destroy ]
  end

  namespace :my do
    resource :dashboard, :only => :show
    resource :account, :only => %i[ show update destroy ]
    resources :albums, :only => [] do
      resource :purchases, :only => %i[ create destroy ]
    end

    get "/purchases/:fan_uuid/:album_uuid" => "purchases#new",
      :as => :purchase
  end

  root :to => "home#index"
end
