# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.0.1"

gem "dotenv-rails", :groups => %i[ development test ]

gem "pg", "~> 1.2"
gem "puma", "~> 5.0"
gem "rails", "~> 6.1.0"

gem "sass-rails", ">= 6"
gem "turbolinks", "~> 5"
gem "webpacker", "6.0.0.beta.7"

gem "bootsnap", ">= 1.4.2", :require => false
gem "decent_exposure",
  :git    => "https://github.com/pat/decent_exposure.git",
  :branch => "ruby-3.0-support"
gem "devise"
gem "faraday"
gem "lastfm"
gem "musicbrainz", :git => "https://github.com/inkstak/musicbrainz.git"
gem "nokogiri"
gem "omniauth"
gem "omniauth-rails_csrf_protection"
gem "postmark-rails"
gem "premailer-rails"
gem "rspotify",
  :git    => "https://github.com/pat/rspotify.git",
  :branch => "chore/unpin-addressable"
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
