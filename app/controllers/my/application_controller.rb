# frozen_string_literal: true

module My
  class ApplicationController < ::ApplicationController
    before_action :authenticate_fan!
  end
end
