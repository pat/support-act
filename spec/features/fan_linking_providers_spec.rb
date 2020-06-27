# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Fan linking providers", :type => :feature do
  let(:fan) do
    Fan.create(
      :email                 => "pat@music.fans",
      :password              => "sing-to-the-moon",
      :password_confirmation => "sing-to-the-moon",
      :confirmed_at          => 1.minute.ago
    )
  end

  before :each do
    visit new_fan_session_path
    fill_in "Email", :with => fan.email
    fill_in "Password", :with => fan.password
    click_button "Log in"

    ActionMailer::Base.deliveries.clear
  end

  it "Spotify" do
    stub_request(:get, %r{https://api.spotify.com/v1/me/top/tracks}).to_return(
      :body    => JSON.dump({"items" => []}),
      :headers => {"Content-Type" => "application/json"}
    )

    visit my_dashboard_path
    click_link "Connect to Spotify"

    fan.reload

    expect(fan.provider).to eq("spotify")
  end

  def stub_last_fm_request(method, output)
    stub_request(
      :get, %r{http://ws.audioscrobbler.com/2.0/.*method=#{method}}
    ).to_return(
      :headers => {"Content-Type" => "application/xml"},
      :body    => <<~XML
        <?xml version="1.0" encoding="utf-8"?>
        <lfm status="ok">
          #{output}
        </lfm>
      XML
    )
  end

  it "Last.fm" do
    stub_last_fm_request "auth.getSession", <<~XML
      <session>
        <name>supportactfan</name>
        <key>#{SecureRandom.uuid}</key>
        <subscriber>0</subscriber>
      </session>
    XML

    stub_last_fm_request "user.getInfo", <<~XML
      <user>
        <id>1</id>
        <name>supportactfan</name>
      </user>
    XML

    stub_last_fm_request "user.getTopAlbums", <<~XML
      <topalbums user="supportactfan" type="1month">
        <album rank="1">
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
        <album rank="2">
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
      </topalbums>
    XML

    visit my_dashboard_path
    # Skip the initial request to Last.fm, jump to their expected redirect back
    visit "/last_fm/connection?token=#{SecureRandom.uuid}"

    fan.reload

    expect(fan.provider).to eq("last.fm")
  end
end
