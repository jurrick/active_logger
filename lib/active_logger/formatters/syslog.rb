# frozen_string_literal: true

require 'syslog'
require 'syslog_protocol'

module ActiveLogger
  module Formatters
    class Syslog < Base # :nodoc:
      attr_accessor :facility, :hostname, :maxsize

      class LevelMap # :nodoc:
        attr_accessor :trace, :debug, :info, :warn, :error, :fatal

        def initialize(debug: ::Syslog::LOG_DEBUG, info: ::Syslog::LOG_INFO, warn: ::Syslog::LOG_WARNING, error: ::Syslog::LOG_ERR, fatal: ::Syslog::LOG_CRIT)
          @debug = debug
          @info  = info
          @warn  = warn
          @error = error
          @fatal = fatal
        end

        def [](level)
          public_send(level.to_s.downcase)
        end
      end

      def initialize(hostname: nil, facility: nil, maxsize: nil)
        @hostname = hostname
        @facility = facility
        @maxsize = maxsize
      end

      def call(severity, timestamp, progname, msg)
        message = "#{tags_text}#{msg}"
        program = progname || default_progname

        syslog_packet(
          tag: program.delete(' '),
          content: message,
          time: timestamp,
          severity: LevelMap.new[severity],
          facility: @facility,
          maxsize: @maxsize || 1024,
          host: @hostname
        )
      end

      def syslog_packet(tag:, content:, facility: nil, time: nil, severity: nil, host: nil, maxsize: nil)
        packet          = SyslogProtocol::Packet.new
        packet.hostname = host || `hostname`.chomp
        packet.facility = facility || 'user'
        packet.tag      = tag
        packet.content  = content
        packet.time     = time
        packet.severity = severity || 'notice'
        maxsize ? packet.assemble(maxsize) : packet.assemble
      end
    end
  end
end
