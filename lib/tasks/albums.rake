# frozen_string_literal: true

namespace :albums do
  task :complete => :environment do
    Parsers::LastFm::UpdateUnknown.call
    Parsers::Spotify::UpdateUnknown.call
  end

  task :links => :environment do
    Album.unlinked.with_mbid.find_each do |album|
      Parsers::MusicBrainz::Links.call(album)
      sleep 1.1 # to avoid MusicBrainz rate-limits.
    end
  end
end
