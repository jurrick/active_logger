# frozen_string_literal: true

RSpec.describe ActiveLogger::Logger do
  [
    [:stdout],
    [:stderr],
    [STDOUT],
    [STDERR],
    [:file, filename: 'log/test.log'],
    [:file, filename: 'log/test.log', keep: 5],
    [:file, filename: 'log/test.log', size: 1000],
    [:file, filename: 'log/test.log', size: 1000, keep: 5]
  ].each do |args|
    describe "with arguments #{args.inspect}" do
      it do
        logger = described_class.new args[0], args[1]

        expect(logger).to be_a_kind_of(ActiveSupport::Logger)
      end
    end
  end

  describe 'without arguments' do
    it do
      expect { described_class.new }.to raise_error(ActiveLogger::Logger::AdapterNotFound)
    end
  end

  describe 'with fail argument' do
    it do
      expect { described_class.new :unknown }.to raise_error(ActiveLogger::Logger::AdapterNotFound)
    end
  end
end
