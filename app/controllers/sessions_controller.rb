# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  rescue_from ActionController::InvalidAuthenticityToken do
    flash[:alert] = "Your session timed out, please try again."

    redirect_to new_fan_session_path
  end
end
