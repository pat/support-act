# frozen_string_literal: true

class ApplicationController < ActionController::Base
  private

  def authenticate
    return if signed_in? && current_fan.present?

    redirect_to new_session_path
  end

  def current_fan
    return nil unless session[:fan_uuid]

    @current_fan ||= Fan.find_by(:identifier => session[:fan_uuid])
  end
  helper_method :current_fan

  def signed_in?
    session[:fan_uuid].present?
  end
end
