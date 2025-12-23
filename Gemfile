# frozen_string_literal: true

source "https://gem.coop"

ruby :file => ".tool-versions"

gem "dotenv-rails", :groups => %i[ development test ]

gem "pg", "~> 1.2"
gem "puma", "~> 7.0"
gem "rails", "~> 8.1.1"

gem "sass-rails", ">= 6"
gem "turbolinks", "~> 5"
gem "webpacker", "6.0.0.rc.6"

gem "bootsnap", ">= 1.4.2", :require => false
gem "csv" # For lastfm gem
gem "decent_exposure"
gem "devise"
gem "faraday"
gem "invisible_captcha"
gem "lastfm"
gem "musicbrainz", :git => "https://github.com/inkstak/musicbrainz.git"
gem "nokogiri"
gem "omniauth"
gem "omniauth-rails_csrf_protection"
gem "postmark-rails"
gem "premailer-rails"
gem "rspotify"
gem "rubocop"
gem "rubocop-performance"
gem "rubocop-rails"

group :production do
  gem "bugsnag"
end

group :development, :test do
  gem "byebug", :platforms => %i[mri windows]
  gem "rspec-rails"
end

group :development do
  gem "sslocal"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara"
  gem "capybara-email"
  gem "webmock"
end
