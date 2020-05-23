# frozen_string_literal: true

class SuggestionsMailer < ApplicationMailer
  def suggest(fan)
    @fan = fan

    @albums = Album.
      where(:id => fan.provider_cache["latest_album_ids"][0..19]).
      includes(:artist).
      order(:id)

    @purchases = Purchase.where(:fan => fan, :album => @albums)

    mail :to => fan.email
  end
end
