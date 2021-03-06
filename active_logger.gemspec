# frozen_string_literal: true

require_relative 'lib/active_logger/version'

Gem::Specification.new do |spec|
  spec.name          = 'active_logger'
  spec.version       = ActiveLogger::VERSION
  spec.authors       = ['Yury Snegirev']
  spec.email         = ['jurianp@gmail.com']

  spec.summary       = 'Logger based on ActiveSupport::Logger'
  spec.homepage      = 'https://github.com/jurrick/active_logger'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  # spec.metadata['changelog_uri'] = 'TODO: Put your gem\'s CHANGELOG.md URL here.'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency('activesupport', '>= 5.0.0')
end
