# frozen_string_literal: true

RSpec.describe ActiveLogger do
  subject(:logger) { described_class.new STDOUT }

  it 'has a version number' do
    expect(ActiveLogger::VERSION).not_to be nil
  end

  it do
    expect(logger).to be_a_kind_of(ActiveSupport::Logger)
  end
end
