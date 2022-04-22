# frozen_string_literal: true

MusicBrainz.configure do |c|
  c.app_name    = "Support Act"
  c.app_version = "1.0.0"
  c.contact     = ENV.fetch("SENDER")

  if ENV.fetch("SENDER").end_with?(">")
    c.contact = ENV.fetch("SENDER")[/<(.+)>$/, 1]
  end
end
