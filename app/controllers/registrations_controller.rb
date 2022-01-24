# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  invisible_captcha :only => %i[ create ]
end
