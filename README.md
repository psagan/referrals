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

After that run:
```bash
bin/rails referrals:install:migrations
```
It will copy engine's migrations to your project.
Now migrate:
```bash
# Rails 4
bin/rake db:migrate

# Rails 5
bin/rails db:migrate
```


## Integration with Rails
**Controller helpers**

Handling referral cookies
```ruby
# in your controller where you want to have cookies handling available
class ApplicationController < ActionController::Base
  include Referrals::CookiesConcern  
  # ...  
end  
```

Assigning referrals to partner
```ruby
# in your controller where you want to assign user to partner
class RegistrationsController < ActionController::Base
  include Referrals::OperationsConcern  
  # ...  
  def register
    # eg: assign referrals to partner when user
    # just registered
    # Now resource under 'registered_user' will be assigned to partner
    # based on value in cookie
    assign_referral_to_partner(registered_user)
  end
end  
```

Capturing referral action
```ruby
# in your controller where you want to capture referral action
class PaymentController < ActionController::Base
  include Referrals::OperationsConcern  
  
  def make_payment   
    capture_referral_action(referral: current_user, amount: 10.30, info: 'Payment for subscription')
    render plain: 'ok'
  end
  
  
end
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
