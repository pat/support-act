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
    all_links = album.links.values.flatten
    return NO_LINKS if all_links.blank?

    links = all_links.select do |link|
      PURCHASE_PATTERNS.values.any? { |pattern| link[pattern] }
    end

    PURCHASE_PATTERNS.
      collect { |_label, pattern| links.detect { |link| link[pattern] } }.
      compact
  end

  def artist_homepage(artist)
    Array(artist.links.dig("musicbrainz", "official homepage")).first
  end
end
