# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    redirect_to "http://www.last.fm/api/auth/?api_key=#{ENV["LAST_FM_API_KEY"]}&cb=#{new_authentication_url}"
  end

  private

  def last_fm
    @last_fm ||= Lastfm.new(ENV["LAST_FM_API_KEY"], ENV["LAST_FM_API_SECRET"])
  end
end
