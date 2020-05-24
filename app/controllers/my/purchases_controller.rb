# frozen_string_literal: true

module My
  class PurchasesController < My::ApplicationController
    def create
      fan = Fan.find_by!(:identifier => params[:fan_uuid])
      album = Album.find_by!(:identifier => params[:album_uuid])

      Purchase.create!(:fan => fan, :album => album)

      redirect_to my_dashboard_path
    end
  end
end
