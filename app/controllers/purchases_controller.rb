# frozen_string_literal: true

class PurchasesController < ApplicationController
  def create
    fan = Fan.find_by!(:identifier => params[:fan_uuid])
    album = Album.find_by!(:identifier => params[:album_uuid])

    Purchase.create!(:fan => fan, :album => album)

    redirect_to "/"
  end
end
