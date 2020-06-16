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

    fill_in "Email", :with => "pat@different.domain"
    click_button "Save"

    expect(page).to have_content("New details have been saved")
    expect(Fan.first.unconfirmed_email).to eq("pat@different.domain")

    email = emails_sent_to("pat@different.domain").detect do |mail|
      mail.subject == "Confirmation instructions"
    end
    expect(email).to be_present

    email.click_link "Confirm my account"

    expect(Fan.first.email).to eq("pat@different.domain")
  end
end
