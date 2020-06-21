# frozen_string_literal: true

module My
  class PurchasesController < My::ApplicationController
    def new
      fan = Fan.find_by!(:identifier => params[:fan_uuid])
      album = Album.find_by!(:identifier => params[:album_uuid])

      Purchase.create!(:fan => fan, :album => album)

      redirect_to my_dashboard_path
    end

    def create
      Purchase.create(:fan => current_fan, :album_id => params[:album_id])

      respond_to do |format|
        format.html { redirect_to my_dashboard_path }
        format.js
      end
    end

    def destroy
      Purchase.find_by(
        :fan      => current_fan,
        :album_id => params[:album_id]
      )&.destroy

      respond_to do |format|
        format.html { redirect_to my_dashboard_path }
        format.js
      end
    end
  end
end
