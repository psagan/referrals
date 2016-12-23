# referrals [under development - not yet production ready]

[![Build Status](https://travis-ci.org/psagan/referrals.svg?branch=master)](https://travis-ci.org/psagan/referrals)
[![Code Climate](https://codeclimate.com/github/psagan/referrals/badges/gpa.svg)](https://codeclimate.com/github/psagan/referrals)
[![Gem Version](https://badge.fury.io/rb/referrals.svg)](https://badge.fury.io/rb/referrals)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Referrals engine dedicated for Ruby on Rails based applications

# Referrals
Short description and motivation.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'referrals'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install referrals
```
## Integration with Rails
**Controller helper**
```ruby
# in your controller where you want have cookies handling available
class ApplicationController < ActionController::Base
  include Referrals::CookiesConcern
  # ...
end  
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
