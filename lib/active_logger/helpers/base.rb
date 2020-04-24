# frozen_string_literal: true

module ActiveLogger #:nodoc:
  module Helpers # :nodoc:
    module Base #:nodoc:
      extend ActiveSupport::Concern

      class_methods do
        def progname=(progname)
          @progname = progname
        end

        def progname
          @progname
        end

        private

        def reset!
          self.progname = nil
        end
      end
    end
  end
end
