# frozen_string_literal: true

module My
  class DashboardsController < My::ApplicationController
    expose(:unpurchased_albums) { Album.not_purchased_by(current_fan) }
    expose(:purchased_albums) { Album.purchased_by(current_fan) }
  end
end
