# frozen_string_literal: true

namespace :albums do
  task :complete => :environment do
    Parsers::LastFm::UpdateUnknown.call
    Parsers::Spotify::UpdateUnknown.call
  end

  task :links => :environment do
    Parsers::MusicBrainz::AlbumLinks.call
    Parsers::MusicBrainz::ArtistLinks.call
    Parsers::Odesli::Links.call
    Parsers::Bandcamp::Links.call
  end
end
