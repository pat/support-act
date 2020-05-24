# frozen_string_literal: true

class SuggestionsMailer < ApplicationMailer
  def suggest(fan)
    @fan = fan
    @albums = Album.latest_for_fan(fan)
    @purchases = Purchase.for_fan_and_albums(fan, @albums)

    mail :to => fan.email, :subject => "Monthly Suggestions"
  end
end
