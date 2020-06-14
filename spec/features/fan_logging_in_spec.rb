# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Fan logging in", :type => :feature do
  let(:fan) do
    Fan.create(
      :email                 => "pat@music.fans",
      :password              => "sing-to-the-moon",
      :password_confirmation => "sing-to-the-moon",
      :confirmed_at          => 1.minute.ago
    )
  end

  before :each do
    visit "/"

    click_link "Log In"
  end

  it "works with valid credentials" do
    fill_in "Email", :with => fan.email
    fill_in "Password", :with => fan.password
    click_button "Log in"

    expect(page).to have_content("Signed in successfully")
  end

  it "fails with invalid credentials" do
    fill_in "Email", :with => fan.email
    fill_in "Password", :with => "green-garden"
    click_button "Log in"

    expect(page).to have_content("Invalid Email or password")
  end

  it "fails with unconfirmed accounts" do
    fan.update :confirmed_at => nil

    fill_in "Email", :with => fan.email
    fill_in "Password", :with => fan.password
    click_button "Log in"

    expect(page).to have_content("You have to confirm your email address")
  end
end
