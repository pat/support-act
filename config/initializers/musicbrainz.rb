# frozen_string_literal: true

MusicBrainz.configure do |c|
  c.app_name    = "Support Act"
  c.app_version = "1.0.0"
  c.contact     = ENV["SENDER"]
  c.contact     = ENV["SENDER"][/<(.+)>$/, 1] if ENV["SENDER"].end_with?(">")
end
