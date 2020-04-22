# frozen_string_literal: true

module ActiveLogger #:nodoc:
  module Helpers # :nodoc:
    module Base #:nodoc:
      extend ActiveSupport::Concern

      class_methods do
        private

        def reset!; end
      end
    end
  end
end
