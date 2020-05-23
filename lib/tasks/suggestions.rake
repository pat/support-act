# frozen_string_literal: true

namespace :suggestions do
  task :send => :environment do
    Fan.find_each do |fan|
      Parse.call(fan)
      SuggestionsMailer.suggest(fan).deliver_now
    end
  end
end
