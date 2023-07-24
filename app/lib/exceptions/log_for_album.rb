# frozen_string_literal: true

module Exceptions
  class LogForAlbum
    def self.call(...)
      new(...).call
    end

    def initialize(error, album)
      @error = error
      @album = album
    end

    def call
      Bugsnag.notify(error) do |report|
        report.add_tab :album_info, {
          :id     => album.id,
          :name   => album.name,
          :artist => album.artist.name
        }
      end
    end

    private

    attr_reader :error, :album
  end
end
