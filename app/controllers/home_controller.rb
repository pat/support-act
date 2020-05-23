# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :authenticate

  expose(:albums) do
    Album.
      where(:id => current_fan.provider_cache["latest_album_ids"][0..19]).
      includes(:artist).
      order(:id)
  end

  expose(:purchases) do
    Purchase.where(:fan => current_fan, :album => albums)
  end
end
