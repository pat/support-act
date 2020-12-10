# frozen_string_literal: true

source "https://rubygems.org"

ruby "2.7.1"

gem "dotenv-rails", :groups => %i[ development test ]

gem "pg", "~> 1.2"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.0"

gem "sass-rails", ">= 6"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 5.1"

gem "bootsnap", ">= 1.4.2", :require => false
gem "decent_exposure"
gem "devise"
gem "faraday"
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
  gem "listen", "~> 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "sslocal"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara"
  gem "capybara-email"
  gem "webmock"
end
