# frozen_string_literal: true

module ApplicationHelper
  NO_LINKS = [].freeze
  PURCHASE_PATTERNS = {
    "Bandcamp"     => "bandcamp.com",
    "iTunes"       => /itunes\.apple\.com|app=itunes/,
    "Google Store" => "play.google.com/store"
  }.freeze

  def purchase_link_label(link)
    PURCHASE_PATTERNS.each do |label, pattern|
      return label if link[pattern]
    end

    raise "Unexpected link: #{link}"
  end

  def purchaseable_links(album)
    return NO_LINKS if album.links["musicbrainz"].blank?

    links = album.links.values.flatten.select do |link|
      PURCHASE_PATTERNS.values.any? { |pattern| link[pattern] }
    end

    PURCHASE_PATTERNS.
      collect { |_label, pattern| links.detect { |link| link[pattern] } }.
      compact
  end
end
