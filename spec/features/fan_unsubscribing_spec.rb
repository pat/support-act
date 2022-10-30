# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Fan unsubscribing", :type => :feature do
  let(:fan) do
    Fan.create(
      :email                 => "pat@music.fans",
      :password              => "sing-to-the-moon",
      :password_confirmation => "sing-to-the-moon",
      :confirmed_at          => 1.minute.ago
    )
  end

  before :each do
    ActionMailer::Base.deliveries.clear
  end

  it "marks them as unsubscribed" do
    expect(fan.reload).to be_subscribed

    visit unsubscribe_path(fan.identifier)

    expect(page).to have_content("You have been unsubscribed")
    expect(fan.reload).not_to be_subscribed
  end
end
