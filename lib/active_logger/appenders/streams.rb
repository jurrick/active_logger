# frozen_string_literal: true

module ActiveLogger
  module Appenders
    class Stdout < ActiveSupport::Logger # :nodoc:
      include ActiveLogger::Appenders::Base

      def initialize(options)
        super(STDOUT, *options)
      end
    end

    class Stderr < ActiveSupport::Logger # :nodoc:
      include ActiveLogger::Appenders::Base

      def initialize(options)
        super(STDERR, *options)
      end
    end
  end
end
