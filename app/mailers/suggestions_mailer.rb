# frozen_string_literal: true

class SuggestionsMailer < ApplicationMailer
  def suggest(fan)
    @fan = fan
    @albums = Album.not_purchased_by(fan)

    mail :to => fan.email, :subject => "Monthly Suggestions"
  end
end
