# frozen_string_literal: true

module ActiveLogger
  module Logger # :nodoc:
    class AdapterNotFound < StandardError; end

    class << self
      def new(*args, &_block)
        # extract options
        options = args.last.is_a?(Hash) ? args.pop : {}

        setup(args.first, options)
      end

      def setup(type, options)
        case type
        when :stdout, STDOUT
          ActiveSupport::Logger.new(STDOUT)
        when :stderr, STDERR
          ActiveSupport::Logger.new(STDERR)
        when String, Pathname
          ActiveSupport::Logger.new(type)
        when :file
          ActiveSupport::Logger.new(options[:filename], options[:keep], options[:size])
        else
          raise AdapterNotFound
        end
      end
    end
  end
end
