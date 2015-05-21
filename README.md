# Crunchbase::Ruby::Library

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'crunchbase-ruby-library'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install crunchbase-ruby-library
    
## Usage Examples

Config your user_key, debug somewhere like development.rb, Recommended directory config/initializers/crunchbase.rb

  require 'crunchbase'

  Crunchbase::API.key   = 'user_key'
  Crunchbase::API.debug = false

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/crunchbase-ruby-library/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
