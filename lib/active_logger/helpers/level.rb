# frozen_string_literal: true

module ActiveLogger #:nodoc:
  module Helpers # :nodoc:
    module Level #:nodoc:
      extend ActiveSupport::Concern

      SEVERITIES = %w[DEBUG INFO WARN ERROR FATAL UNKNOWN].freeze

      class LevelNotFound < StandardError; end

      class_methods do
        def level=(severity)
          @__level__ =
            case severity
            when Integer then severity
            when Symbol, String then SEVERITIES.index(severity.to_s.upcase)
            else raise LevelNotFound
            end
        end

        def level
          @__level__
        end

        private

        def reset!
          @__level__ = ActiveSupport::Logger::DEBUG

          super
        end
      end
    end
  end
end
