# frozen_string_literal: true

require 'json'

module ActiveLogger
  module Formatters
    class Json < Base # :nodoc:
      def call(severity, timestamp, progname, msg)
        {
          progname: progname,
          severity: severity,
          timestamp: timestamp.utc.strftime(datetime_format),
          tags: current_tags,
          pid: pid,
          message: msg
        }.to_json + "\n"
      end

      def datetime_format
        '%FT%T.%6NZ'
      end
    end
  end
end
