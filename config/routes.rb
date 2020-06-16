# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :fans

  namespace :last_fm do
    resource :connection, :only => %i[ new show ]
  end

  get "/auth/spotify/callback", :to => "spotify/connections#create"

  namespace :my do
    resource :dashboard, :only => :show
    resource :account, :only => %i[ show update ]
    resources :albums, :only => [] do
      resource :purchases, :only => %i[ create destroy ]
    end

    get "/purchases/:fan_uuid/:album_uuid" => "purchases#new",
      :as => :purchase # rubocop:disable Layout/HashAlignment
  end

  root :to => "home#index"
end
