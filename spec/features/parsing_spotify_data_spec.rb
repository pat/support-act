# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Parsing Spotify data" do
  let(:fan) do
    Fan.create(
      :email                 => "pat@music.fans",
      :password              => "sing-to-the-moon",
      :password_confirmation => "sing-to-the-moon",
      :confirmed_at          => 1.minute.ago,
      :provider              => "spotify",
      :provider_identity     => "supportactfan",
      :provider_cache        => {
        "oauth"            => OmniAuth.config.mock_auth[:spotify],
        "latest_album_ids" => []
      }
    )
  end

  before :each do
    stub_request(:get, %r{https://api.spotify.com/v1/me/top/tracks}).to_return(
      :headers => {"Content-Type" => "application/json"},
      :body    => {
        "items" => [
          {
            "album"   => {
              "album_type"             => "ALBUM",
              "artists"                => [{
                "id"   => "0Dy94lW3txJhWQHqNXP1BT",
                "name" => "Laura Mvula",
                "type" => "artist",
                "uri"  => "spotify:artist:0Dy94lW3txJhWQHqNXP1BT"
              }],
              "id"                     => "5TrSm6l3WqUZ8NBJUydlEm",
              "images"                 => [{
                "height" => 640,
                "url"    => "https://i.scdn.co/image/",
                "width"  => 640
              }],
              "name"                   => "Laura Mvula with Metropole Orkest",
              "release_date"           => "2014-08-11",
              "release_date_precision" => "day",
              "total_tracks"           => 12,
              "type"                   => "album",
              "uri"                    => "spotify:album:5TrSm6l3WqUZ8NBJUydlEm"
            },
            "artists" => [{
              "id"   => "0Dy94lW3txJhWQHqNXP1BT",
              "name" => "Laura Mvula",
              "type" => "artist",
              "uri"  => "spotify:artist:0Dy94lW3txJhWQHqNXP1BT"
            }],
            "id"      => "0U7Ck6Fkv8eaueU2YLaAuh",
            "name"    => "Is There Anybody Out There?",
            "type"    => "track",
            "uri"     => "spotify:track:0U7Ck6Fkv8eaueU2YLaAuh"
          }
        ]
      }.to_json
    )
  end

  it "creates unknown albums" do
    Parse.call(fan)

    album = Album.find_by(
      :spotify_url => "spotify:album:5TrSm6l3WqUZ8NBJUydlEm"
    )

    expect(album).to be_present
    expect(album.artist.name).to eq("Laura Mvula")
    expect(album.name).to eq(
      "Laura Mvula with Metropole Orkest"
    )
  end

  it "updates known albums" do
    artist = Artist.create!(
      :name        => "Laura Mvula",
      :spotify_url => "spotify:artist:0Dy94lW3txJhWQHqNXP1BT"
    )
    album = Album.create!(
      :name        => "Metropole Orkest",
      :artist      => artist,
      :spotify_url => "spotify:album:5TrSm6l3WqUZ8NBJUydlEm"
    )

    Parse.call(fan)

    artist.reload
    album.reload

    expect(artist.spotify_raw).to_not be_empty
    expect(album.name).to eq(
      "Laura Mvula with Metropole Orkest"
    )
  end

  it "attaches albums to the fan" do
    Parse.call(fan)

    fan.reload
    album = Album.find_by(
      :spotify_url => "spotify:album:5TrSm6l3WqUZ8NBJUydlEm"
    )

    expect(fan.provider_cache["latest_album_ids"]).to eq([album.id])
  end
end
