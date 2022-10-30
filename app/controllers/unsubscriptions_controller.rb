# frozen_string_literal: true

class UnsubscriptionsController < ApplicationController
  def create
    fan = Fan.find_by(:identifier => params[:fan_uuid])
    fan&.update(:subscribed => false)

    redirect_to root_path, :notice => t(".success")
  end
end
