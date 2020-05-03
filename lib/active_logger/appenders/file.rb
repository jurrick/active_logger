# frozen_string_literal: true

module ActiveLogger
  module Appenders
    class File < ActiveSupport::Logger # :nodoc:
      include ActiveLogger::Appenders::Base

      class FilenameNotSpecified < StandardError; end

      def initialize(options)
        raise FilenameNotSpecified if options[:filename].nil?

        super(options[:filename], options[:keep], options[:size])
      end
    end
  end
end
