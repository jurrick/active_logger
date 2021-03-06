[![Gem Version](http://img.shields.io/gem/v/active_logger.svg)](http://badge.fury.io/rb/active_logger) [![Build Status](https://travis-ci.com/jurrick/active_logger.svg?branch=master)](https://travis-ci.com/jurrick/active_logger)

# ActiveLogger

A rich logger extending the capabilities of the ActiveSupport logger

## Features

* Simple syntax for logging
* Logging to multiple outputs (appenders)
* Tagging
* Global logger name
* Custom formatter

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

# with options
logger = ActiveLogger.new :stdout, level: :debug, formatter: :json, progname: :project1
```

There are 3 types:

* `:stdout` : Messages will be written to STDOUT
* `:stderr` : Messages will be written to STDERR
* `:file` : Messages will be written to a file

Available standard options:

* `level` - log level (`DEBUG`, `INFO`, `WARN`, `ERROR`, `FATAL`)
* `formatter` - format for logs: `:default`, `:json` or own custom formatter.
* `progname` - program name.

### File example

```ruby
logger = ActiveLogger.new :file, filename: 'log/development.log', keep: 30, size: 10
logger.info 'test'
```

where:
* filename - full path to logfile for writing
* keep - count of files for keeping
* size - maximum bytes for one file

### Example: Block and multiple appenders

```ruby
logger = ActiveLogger.new do |al|
  al.appender :stdout
  al.appender :file, filename: 'log/development.log', keep: 30, size: 10
end
logger.info 'test'
```

### Example: Tagging

```ruby
logger = ActiveLogger.new STDOUT
logger.tagged('API').info 'test'

# or

logger.tagged('API') do
  logger.info 'test'
end
```

### Example: Global logger with name

```ruby
ActiveLogger.new STDOUT, name: :logger1, level: :debug
ActiveLogger.new STDOUT, name: :logger2, level: :info

logger1 = ActiveLogger['logger1']
logger1.debug? # true
logger1.debug 'test'

logger2 = ActiveLogger['logger2']
logger2.debug? # false
logger2.info 'test2'
```

### Example: Custom formatter

You can create your own formatter:

```ruby
class Formatter < ActiveLogger::Formatters::Base
  def call(severity, timestamp, progname, msg)
    "[#{severity}] [#{timestamp}] #{msg}"
  end
end

ActiveLogger.new STDOUT, formatter: Formatter
```

### Example: Syslog

You can use syslog (support only UDP protocol):

```ruby
logger = ActiveLogger.new :syslog, url: 'udp://sysloghost.com:514', facility: 'local3', maxsize: 1024
logger.info 'test' # => <13>May  3 19:09:23 localhost console: test
```

Available options:

* `url` - full url to syslog
* `facility` - syslog facility (Example: 'user', 'local3', etc)
* `maxsize` - maximum message size

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jurrick/active_logger.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
