# frozen_string_literal: true

require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/object/blank'

module ActiveLogger
  module Appenders
    module Base # :nodoc:
      def default_formatter
        ActiveLogger::Formatters::Default.new
      end
    end
  end
end
