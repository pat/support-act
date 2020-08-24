# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength, Rails/SkipsModelValidations
namespace :consolidate do
  task :artists => :environment do
    Artist.group(:name).having("count(*) > 1").pluck(:name).each do |name|
      last_fm = Artist.where("name = ? AND last_fm_url IS NOT NULL", name).first
      spotify = Artist.find_by(:name => name, :last_fm_url => nil)

      last_fm.update!(
        :spotify_url => spotify.spotify_url,
        :spotify_raw => spotify.spotify_raw
      )

      Album.where(:artist_id => spotify.id).
        update_all(:artist_id => last_fm.id)

      spotify.destroy
    end
  end

  task :albums => :environment do
    query = Album.group(:name, :artist_id).
      having("count(*) > 1").
      pluck(:name, :artist_id)

    query.each do |name, id|
      last_fm = Album.where(
        "name = ? AND artist_id = ? AND last_fm_url IS NOT NULL", name, id
      ).first
      spotify = Album.find_by(
        :name => name, :artist_id => id, :last_fm_url => nil
      )
      next if last_fm.nil?

      last_fm.update!(
        :spotify_url => spotify.spotify_url,
        :spotify_raw => spotify.spotify_raw,
        :image       => spotify.image
      )

      Fan.find_each do |fan|
        next if fan.provider_cache.nil?
        next if fan.provider_cache["latest_album_ids"].nil?

        fan.provider_cache_will_change!
        fan.provider_cache["latest_album_ids"].collect! do |original_id|
          original_id == spotify.id ? last_fm.id : original_id
        end
        fan.save
      end

      Purchase.where(:album_id => spotify.id).
        update_all(:album_id => last_fm.id)

      spotify.destroy
    end
  end
end
# rubocop:enable Metrics/BlockLength, Rails/SkipsModelValidations
