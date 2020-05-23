# frozen_string_literal: true

class AuthenticationsController < ApplicationController
  def new
    last_fm_session = last_fm.auth.get_session(:token => params[:token])
    last_fm.session = last_fm_session["key"]

    fan = Fan.find_or_initialize_by(
      :provider          => "last.fm",
      :provider_identity => last_fm.user.get_info["name"]
    )

    fan.identifier ||= SecureRandom.uuid
    fan.provider_cache["token"] = last_fm_session["key"]
    fan.save!

    session[:fan_uuid] = fan.identifier

    redirect_to "/"
  end

  private

  def last_fm
    @last_fm ||= Lastfm.new(ENV["LAST_FM_API_KEY"], ENV["LAST_FM_API_SECRET"])
  end
end
