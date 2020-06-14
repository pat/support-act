# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Fan signing up", :type => :feature do
  before :each do
    visit "/"

    click_link "Sign Up"
  end

  it "works with required data" do
    fill_in "Email", :with => "pat@music.fans"
    fill_in "fan_password", :with => "fugitive-motel"
    fill_in "Confirm Password", :with => "fugitive-motel"
    click_button "Sign up"

    expect(page).to have_content("a confirmation link has been sent")
    expect(Fan.count).to eq(1)
  end

  it "fails when missing data" do
    fill_in "Email", :with => "pat.music.fans"
    click_button "Sign up"

    expect(page).to have_content("prohibited this account from being saved")
    expect(Fan.count).to be_zero
  end
end
