# frozen_string_literal: true

namespace :suggestions do
  task :send => :environment do
    next unless Time.current.day == 1

    Fan.subscribed_with_provider.find_each do |fan|
      Parse.call(fan)

      if Album.not_purchased_by(fan).any?
        SuggestionsMailer.suggest(fan).deliver_now
      end
    rescue StandardError => error
      Bugsnag.notify(error) do |report|
        report.add_tab :fan_info, {:id => fan.id, :email => fan.email}
      end
    end
  end
end
