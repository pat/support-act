# frozen_string_literal: true

namespace :suggestions do
  task :send => :environment do
    next unless Time.current.day == 1

    Fan.confirmed.with_provider.find_each do |fan|
      Parse.call(fan)

      if Album.not_purchased_by(fan).any?
        SuggestionsMailer.suggest(fan).deliver_now
      end
    end
  end
end
