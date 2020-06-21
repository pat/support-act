# frozen_string_literal: true

namespace :fans do
  task :parse => :environment do
    Fan.confirmed.with_provider.find_each do |fan|
      Parse.call(fan)
    end
  end
end
