# Codeforces API Client Library

The wrapper library for Codeforces API written in Ruby.

[![Gem Version](https://img.shields.io/gem/v/codeforces.svg?style=flat)](https://rubygems.org/gems/codeforces)
[![Build Status](https://img.shields.io/travis/sh19910711/codeforces-api-client.svg?style=flat)](https://travis-ci.org/sh19910711/codeforces-api-client)
[![Code Climate](https://img.shields.io/codeclimate/github/sh19910711/codeforces-api-client.svg?style=flat)](https://codeclimate.com/github/sh19910711/codeforces-api-client)
[![Test Coverage](https://img.shields.io/codeclimate/coverage/github/sh19910711/codeforces-api-client.svg?style=flat)](https://codeclimate.com/github/sh19910711/codeforces-api-client)
[![API Doc](http://img.shields.io/badge/RubyDocs-API-green.svg?style=flat)](http://www.rubydoc.info/github/sh19910711/codeforces-api-client)

## 0. Installation

Add this line to your application's Gemfile:

```ruby
gem "codeforces"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install codeforces

## 1. Usage

### Helper Method

```ruby
require "codeforces"

Codeforces.each_contest do |contest|
  puts contest.name
end
```

```ruby
require "codeforces"

tourist = Codeforces.user("tourist")

puts tourist.rating
# -> 3254

puts tourist.rank
# -> international grandmaster
```

See also: [rubydocs](http://www.rubydoc.info/github/sh19910711/codeforces-api-client/Codeforces/Helper)

### API Access

```ruby
require "codeforces"

Codeforces.api.contest.list.each do |contest|
  puts contest.name
end
```

See also: http://codeforces.com/api/help/methods

## 2. Contributing

1. Fork it ( https://github.com/sh19910711/codeforces-api-client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

