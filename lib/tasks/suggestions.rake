# frozen_string_literal: true

namespace :suggestions do
  task :send => :environment do
    next unless Time.current.day == 1

    Fan.find_each do |fan|
      Parse.call(fan)
      SuggestionsMailer.suggest(fan).deliver_now
    end
  end
end
