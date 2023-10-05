# frozen_string_literal: true

source "https://rubygems.org"

ruby "~> 3.2.2"

gem "dotenv-rails", :groups => %i[ development test ]

gem "pg", "~> 1.2"
gem "puma", "~> 6.0"
gem "rails", "~> 7.1.0"

gem "sass-rails", ">= 6"
gem "turbolinks", "~> 5"
gem "webpacker", "6.0.0.rc.6"

gem "bootsnap", ">= 1.4.2", :require => false
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
  gem "byebug", :platforms => %i[mri mingw x64_mingw]
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
