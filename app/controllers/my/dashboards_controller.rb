# frozen_string_literal: true

module My
  class DashboardsController < My::ApplicationController
    expose(:albums) { Album.latest_for_fan(current_fan) }
    expose(:purchases) { Purchase.for_fan_and_albums(current_fan, albums) }
  end
end
