# frozen_string_literal: true

require 'English'

module ActiveLogger
  module Formatters
    class Base < ActiveSupport::Logger::Formatter # :nodoc:
      def call(severity, timestamp, progname, msg)
        super(severity, timestamp, progname, msg)
      end

      def tagged(*tags)
        new_tags = push_tags(*tags)
        yield self
      ensure
        pop_tags(new_tags.size)
      end

      def push_tags(*tags)
        @tags_text = nil
        tags.flatten!
        tags.reject!(&:blank?)
        current_tags.concat tags
        tags
      end

      def pop_tags(size = 1)
        @tags_text = nil
        current_tags.pop size
      end

      def clear_tags!
        @tags_text = nil
        current_tags.clear
      end

      def current_tags
        # We use our object ID here to avoid conflicting with other instances
        thread_key = @thread_key ||= "activelogger_tagged_logging_tags:#{object_id}"
        Thread.current[thread_key] ||= []
      end

      def tags_text
        @tags_text ||= begin
          tags = current_tags
          if tags.one?
            "[#{tags[0]}] "
          elsif tags.any?
            tags.collect { |tag| "[#{tag}] " }.join
          end
        end
      end

      def pid
        $PID
      end

      def default_progname
        $PROGRAM_NAME
      end
    end
  end
end
