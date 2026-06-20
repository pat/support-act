# frozen_string_literal: true

class FanMailer < ApplicationMailer
  helper :application

  def reconnect_spotify(fan)
    @fan = fan

    mail :to => fan.email
  end
end
