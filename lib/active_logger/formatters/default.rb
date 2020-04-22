# frozen_string_literal: true
# frozen_string_literal: true

module ActiveLogger
  module Formatters
    class Default < Base # :nodoc:
      def call(severity, timestamp, progname, msg)
        super(severity, timestamp, progname, "#{tags_text}#{msg}")
      end
    end
  end
end
