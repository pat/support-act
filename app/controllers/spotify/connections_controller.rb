# frozen_string_literal: true

module Spotify
  class ConnectionsController < ApplicationController
    before_action :authenticate_fan!

    def create
      current_fan.update!(
        :provider          => "spotify",
        :provider_identity => spotify_user.id,
        :provider_cache    => {
          "oauth"            => spotify_user.to_hash,
          "latest_album_ids" => []
        }
      )

      Parse.call(current_fan)

      redirect_to my_dashboard_path
    end

    def destroy
      current_fan.update!(
        :provider          => nil,
        :provider_identity => nil,
        :provider_cache    => {}
      )

      redirect_to my_dashboard_path, :notice => t(".success")
    end

    private

    def spotify_user
      @spotify_user ||= RSpotify::User.new(request.env["omniauth.auth"])
    end
  end
end
