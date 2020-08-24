# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Parsing Last.fm data" do
  let(:fan) do
    Fan.create(
      :email                 => "pat@music.fans",
      :password              => "sing-to-the-moon",
      :password_confirmation => "sing-to-the-moon",
      :confirmed_at          => 1.minute.ago,
      :provider              => "last.fm",
      :provider_identity     => "supportactfan",
      :provider_cache        => {
        "token"            => SecureRandom.uuid,
        "latest_album_ids" => []
      }
    )
  end

  before :each do
    stub_request(
      :get, %r{http://ws.audioscrobbler.com/2.0/.*method=user.getTopAlbums}
    ).to_return(
      :headers => {"Content-Type" => "application/xml"},
      :body    => <<~XML
        <?xml version="1.0" encoding="utf-8"?>
        <lfm status="ok">
          <topalbums user="supportactfan" type="1month">
            <album rank="1">
              <name>Better in Blak</name>
              <mbid>#{SecureRandom.uuid}</mbid>
              <url>http://www.last.fm/music/Thelma+Plum/Better+in+Blak</url>
              <artist>
                <name>Thelma Plum</name>
                <mbid>#{SecureRandom.uuid}</mbid>
                <url>http://www.last.fm/music/Thelma+Plum</url>
              </artist>
              <image size="large">https://last.fm/url-for-image</image>
            </album>
            <album rank="2">
              <name>String Quartet Live!</name>
              <mbid>#{SecureRandom.uuid}</mbid>
              <url>http://www.last.fm/music/Kishi+Bashi/String+Quartet+Live!</url>
              <artist>
                <name>Kishi Bashi</name>
                <mbid>#{SecureRandom.uuid}</mbid>
                <url>http://www.last.fm/music/Kishi+Bashi</url>
              </artist>
              <image size="large">https://last.fm/url-for-image</image>
            </album>
          </topalbums>
        </lfm>
      XML
    )
  end

  it "creates unknown albums" do
    Parse.call(fan)

    album = Album.find_by(
      :last_fm_url => "http://www.last.fm/music/Kishi+Bashi/String+Quartet+Live!"
    )

    expect(album).to be_present
    expect(album.artist.name).to eq("Kishi Bashi")
    expect(album.name).to eq("String Quartet Live!")
  end

  it "updates known albums" do
    artist = Artist.create!(
      :name        => "Thelma Plum",
      :last_fm_url => "http://www.last.fm/music/Thelma+Plum"
    )
    album = Album.create!(
      :name        => "Better in Black",
      :artist      => artist,
      :last_fm_url => "http://www.last.fm/music/Thelma+Plum/Better+in+Blak"
    )

    Parse.call(fan)

    artist.reload
    album.reload

    expect(artist.mbid).to_not be_empty
    expect(album.name).to eq("Better in Blak")
  end

  it "attaches albums to the fan" do
    Parse.call(fan)

    fan.reload

    thelma = Album.find_by(
      :last_fm_url => "http://www.last.fm/music/Thelma+Plum/Better+in+Blak"
    )
    kishi = Album.find_by(
      :last_fm_url => "http://www.last.fm/music/Kishi+Bashi/String+Quartet+Live!"
    )

    expect(fan.provider_cache["latest_album_ids"]).to eq([thelma.id, kishi.id])
  end
end
