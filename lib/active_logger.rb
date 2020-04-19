# frozen_string_literal: true

require 'active_support/logger'

module ActiveLogger # :nodoc:
  class << self
    def new(*args, &block)
      ActiveLogger::Logger.new(*args, &block)
    end
  end
end

require File.dirname(__FILE__) + '/active_logger/logger'
