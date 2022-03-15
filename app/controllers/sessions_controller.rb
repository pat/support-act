# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  rescue_from ActionController::InvalidAuthenticityToken do
    flash[:alert] = t("sessions.invalid_token")

    redirect_to new_fan_session_path
  end
end
