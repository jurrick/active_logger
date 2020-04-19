[![Gem Version](http://img.shields.io/gem/v/active_logger.svg)](http://badge.fury.io/rb/active_logger) [![Build Status](https://travis-ci.com/jurrick/active_logger.svg?branch=master)](https://travis-ci.com/jurrick/active_logger)

# ActiveLogger

A rich logger extending the capabilities of the ActiveSupport logger

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_logger'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install active_logger

## Usage

### Basic example

```ruby
logger = ActiveLogger.new :stdout
logger.info 'test' # => test
```

There are 3 types:

* `:stdout` : Messages will be written to STDOUT
* `:stderr` : Messages will be written to STDERR
* `:file` : Messages will be written to a file

### File example

```ruby
logger = ActiveLogger.new :file, filename: 'log/development.log', keep: 30, size: 10
logger.info 'test'

# Alternative
logger = ActiveLogger.new 'log/development.log', keep: 30, size: 10
logger.info 'test'
```

where:
* filename - full path to logfile for writing
* keep - count of files for keeping
* size - maximum bytes for one file

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jurrick/active_logger.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
