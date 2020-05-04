# frozen_string_literal: true

require 'logger'
require 'uri'
require 'socket'
require 'English'

module ActiveLogger
  module Appenders
    class Syslog < ActiveSupport::Logger # :nodoc:
      include ActiveLogger::Appenders::Base

      class UrlNotKnown < StandardError; end

      class UdpDevice # :nodoc:
        def initialize(host:, port: 514)
          @host = host
          @port = port
          @socket = UDPSocket.new
        end

        def write(message)
          @socket.send(message, 0, @host, @port)
        rescue StandardError => e
          warn "#{self.class} error: #{$ERROR_INFO.class}: #{$ERROR_INFO}\nOriginal message: #{message} #{e.backtrace.join("\n")}"
          raise e
        end

        def close
          @socket.close
        end
      end

      def initialize(options)
        url = options.delete(:url)
        uri = URI(url)
        host = uri.host || 'localhost'
        protocol = (uri.scheme || :syslog).to_sym
        port = uri.port || 514
        @maxsize = options.delete(:maxsize) || 1024
        @facility = options.delete(:facility) || 'user'

        case protocol
        when :udp
          super(UdpDevice.new(host: host, port: port))
        else
          raise UrlNotKnown, protocol
        end
      end

      def default_formatter
        ActiveLogger::Formatters::Syslog.new(maxsize: @maxsize, facility: @facility)
      end
    end
  end
end
