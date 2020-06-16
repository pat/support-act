# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Fan editing details", :type => :feature do
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

  it "changing email address" do
    click_link "My Account"

    within(".edit-fan-email") do
      fill_in "Email", :with => "pat@different.domain"
      click_button "Save"
    end

    expect(page).to have_content("New details have been saved")
    expect(Fan.first.unconfirmed_email).to eq("pat@different.domain")

    email = emails_sent_to("pat@different.domain").detect do |mail|
      mail.subject == "Confirmation instructions"
    end
    expect(email).to be_present

    email.click_link "Confirm my account"

    expect(Fan.first.email).to eq("pat@different.domain")
  end

  it "changing password" do
    click_link "My Account"

    within(".edit-fan-password") do
      fill_in "Password", :with => "re:member"
      fill_in "Confirm Password", :with => "re:member"
      click_button "Save"
    end

    fill_in "Email", :with => fan.email
    fill_in "Password", :with => "re:member"
    click_button "Log in"

    expect(page).to have_content("Signed in successfully")
  end

  it "disconnecting last.fm" do
    fan.update(
      :provider          => "last.fm",
      :provider_identity => "freelancing_god",
      :provider_cache    => {"token" => SecureRandom.uuid}
    )

    click_link "My Account"
    click_link "Disconnect Last.fm"

    expect(page).to have_content("Last.fm has been disconnected")
    expect(fan.reload).to have_attributes(
      :provider          => nil,
      :provider_identity => nil,
      :provider_cache    => {}
    )
  end

  it "disconnecting Spotify" do
    fan.update(
      :provider          => "spotify",
      :provider_identity => "freelancing_god",
      :provider_cache    => {"token" => SecureRandom.uuid}
    )

    click_link "My Account"
    click_link "Disconnect Spotify"

    expect(page).to have_content("Spotify has been disconnected")
    expect(fan.reload).to have_attributes(
      :provider          => nil,
      :provider_identity => nil,
      :provider_cache    => {}
    )
  end
end
