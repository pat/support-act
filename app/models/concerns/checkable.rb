# frozen_string_literal: true

module Checkable
  extend ActiveSupport::Concern

  included do
    has_many :service_checks, :as => :checkable, :dependent => :delete_all

    scope :without_recent_check, lambda { |service|
      join = sanitize_sql([join_clause, service])
      joins(join).merge(ServiceCheck.missing_or_old)
    }
  end

  class_methods do
    def each_unchecked(service)
      without_recent_check(service).find_each do |checkable|
        ServiceCheck.check(checkable, service) do
          yield checkable
        end
      end
    end

    def join_clause
      "LEFT OUTER JOIN service_checks ON checkable_id = " \
        "#{table_name}.id AND checkable_type = '#{self}' AND service = ?"
    end
  end
end
