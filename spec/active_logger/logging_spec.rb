# frozen_string_literal: true

RSpec.describe ActiveLogger::Logging do
  [
    [:stdout],
    [:stderr],
    [STDOUT],
    [STDERR],
    [:file, filename: 'log/test.log'],
    [:file, filename: 'log/test.log', keep: 5],
    [:file, filename: 'log/test.log', size: 1000],
    [:file, filename: 'log/test.log', size: 1000, keep: 5],
    [proc { |al| al.appender(:stdout) }],
    [proc do |al|
       al.appender(:stdout)
       al.appender(:file, filename: 'log/test.log', size: 100, keep: 5)
     end]
  ].each do |args|
    describe "with arguments #{args.inspect}" do
      let(:logger) { args[0].is_a?(Proc) ? described_class.new(&args[0]) : described_class.new(args[0], args[1]) }

      it do
        expect(logger).to be_a_kind_of(ActiveSupport::Logger)
      end
    end
  end

  describe 'without arguments' do
    it do
      expect { described_class.new }.to raise_error(ActiveLogger::Appenders::NotFound)
    end
  end

  describe 'with fail argument' do
    it do
      expect { described_class.new :unknown }.to raise_error(ActiveLogger::Appenders::NotFound)
    end
  end

  CLASS_SEVERITIES = [Logger::DEBUG, Logger::INFO, Logger::WARN, Logger::ERROR, Logger::FATAL].freeze
  SYMBOL_SEVERITIES = %i[debug info warn error fatal].freeze
  STRING_SEVERITIES = %w[DEBUG INFO WARN ERROR FATAL].freeze

  (CLASS_SEVERITIES + SYMBOL_SEVERITIES + STRING_SEVERITIES).each do |level|
    describe "with argument level #{level.inspect}" do
      let(:logger) { described_class.new :stdout, level: level }

      it do
        eq_level = [Symbol, String].include?(level.class) ? STRING_SEVERITIES.index(level.to_s.upcase) : level
        expect(logger.level).to eq(eq_level)
      end
    end

    describe "with block argument level #{level.inspect}" do
      let(:logger) do
        described_class.new do |al|
          al.level = level
          al.appender :stdout
        end
      end

      it do
        eq_level = [Symbol, String].include?(level.class) ? STRING_SEVERITIES.index(level.to_s.upcase) : level
        expect(logger.level).to eq(eq_level)
      end
    end
  end

  FORMATTERS = [
    { name: :default, class: ActiveLogger::Formatters::Default },
    { name: :json, class: ActiveLogger::Formatters::Json },
    { name: :syslog, class: ActiveLogger::Formatters::Syslog }
  ].freeze

  FORMATTERS.each do |formatter|
    describe "with argument formatter #{formatter[:name].inspect}" do
      let(:logger) { described_class.new :stdout, formatter: formatter[:name] }

      it do
        expect(logger.formatter.class).to eq(formatter[:class])
      end
    end

    describe "with block argument formatter #{formatter[:name].inspect}" do
      let(:logger) do
        described_class.new do |al|
          al.formatter = formatter[:name]
          al.appender :stdout
        end
      end

      it do
        expect(logger.formatter.class).to eq(formatter[:class])
      end
    end
  end

  describe 'with custom argument formatter' do
    let(:formatter) do
      class Formatter < ActiveLogger::Formatters::Base
        def call(severity, timestamp, _progname, msg)
          "[#{severity}] [#{timestamp}] #{msg}"
        end
      end

      Formatter
    end

    let(:logger) { described_class.new :stdout, formatter: formatter.new }

    it do
      expect(logger.formatter.class).to eq(formatter)
    end
  end
end
