# frozen_string_literal: true

namespace :albums do
  task :complete => :environment do
    Parsers::LastFm::UpdateUnknown.call
    Parsers::Spotify::UpdateUnknown.call
  end
end
