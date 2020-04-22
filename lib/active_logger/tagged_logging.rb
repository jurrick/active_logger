# frozen_string_literal: true

require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/object/blank'

module ActiveLogger
  module TaggedLogging # :nodoc:
    module LocalTagStorage # :nodoc:
      attr_accessor :current_tags

      def self.extended(base)
        base.current_tags = []
      end
    end

    def self.new(logger)
      logger = logger.dup

      logger.formatter =
        if logger.formatter
          logger.formatter.dup
        else
          # Ensure we set a default formatter so we aren't extending nil!
          ActiveLogger::Formatters::Default.new
        end

      logger.extend(self)
    end

    delegate :push_tags, :pop_tags, :clear_tags!, to: :formatter

    def tagged(*tags)
      if block_given?
        formatter.tagged(*tags) { yield self }
      else
        logger = ActiveLogger::TaggedLogging.new(self)
        logger.formatter.extend LocalTagStorage
        logger.push_tags(*formatter.current_tags, *tags)
        logger
      end
    end

    def flush
      clear_tags!
      super if defined?(super)
    end
  end
end
