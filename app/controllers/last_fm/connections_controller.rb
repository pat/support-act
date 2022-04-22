# frozen_string_literal: true

module LastFm
  class ConnectionsController < ApplicationController
    URL_PATTERN = "http://www.last.fm/api/auth/?api_key=%<api_key>s&cb=%<url>s"

    before_action :authenticate_fan!

    def new
      redirect_to(
        format(
          URL_PATTERN,
          :api_key => ENV.fetch("LAST_FM_API_KEY"),
          :url     => last_fm_connection_url
        ), :allow_other_host => true
      )
    end

    def show
      current_fan.update!(
        :provider          => "last.fm",
        :provider_identity => last_fm_user.get_info["name"],
        :provider_cache    => {"token" => last_fm.session}
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

    def last_fm
      @last_fm ||= Lastfm.new(
        ENV.fetch("LAST_FM_API_KEY"), ENV.fetch("LAST_FM_API_SECRET")
      ).tap do |lfm|
        lfm.session = lfm.auth.get_session(:token => params[:token])["key"]
      end
    end

    def last_fm_user
      last_fm.user
    end
  end
end
