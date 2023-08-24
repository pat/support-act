# frozen_string_literal: true

namespace :fans do
  task :parse => :environment do
    Fan.confirmed.with_provider.find_each do |fan|
      Parse.call(fan)
    rescue RestClient::Unauthorized,
           RestClient::Forbidden,
           Lastfm::ApiError => error
      Bugsnag.notify(error) do |report|
        report.add_tab :fan_info, {:id => fan.id, :email => fan.email}
      end
    rescue RestClient::ServiceUnavailable
      # This happens occasionally. Continue on to the next fan.
    end
  end
end
