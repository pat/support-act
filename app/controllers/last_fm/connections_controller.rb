# frozen_string_literal: true

module LastFm
  class ConnectionsController < ApplicationController
    URL_PATTERN = "http://www.last.fm/api/auth/?api_key=%<api_key>s&cb=%<url>s"

    before_action :authenticate_fan!

    def new
      redirect_to(
        format(
          URL_PATTERN,
          :api_key => ENV["LAST_FM_API_KEY"],
          :url     => last_fm_connection_url
        )
      )
    end

    def show
      last_fm_session = last_fm.auth.get_session(:token => params[:token])
      last_fm.session = last_fm_session["key"]

      current_fan.update!(
        :provider          => "last.fm",
        :provider_identity => last_fm.user.get_info["name"],
        :provider_cache    => {"token" => last_fm_session["key"]}
      )

      Parse.call(current_fan)

      redirect_to my_dashboard_path
    end

    private

    def last_fm
      @last_fm ||= Lastfm.new(ENV["LAST_FM_API_KEY"], ENV["LAST_FM_API_SECRET"])
    end
  end
end
