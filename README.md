# CrunchBase

A Ruby wrapper fo Crunchbase API v3.1 [CrunchBase Data Hub](https://data.crunchbase.com/v3.1/docs/using-the-api).

[![Gem Version](https://badge.fury.io/rb/crunchbase-ruby-library.svg)](https://badge.fury.io/rb/crunchbase-ruby-library)
[![Build Status](https://travis-ci.org/encoreshao/crunchbase-ruby-library.svg?branch=master)](https://travis-ci.org/encoreshao/crunchbase-ruby-library)
[![Coverage Status](https://coveralls.io/repos/github/encoreshao/crunchbase-ruby-library/badge.svg)](https://coveralls.io/github/encoreshao/crunchbase-ruby-library)

-------

We are building a new gem for Crunchbase API v4.0, it will move to [Ekohe](https://github.com/ekohe/crunchbase4)


### How to installation

Add this line to your application's Gemfile:

    gem 'crunchbase-ruby-library'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install crunchbase-ruby-library

### Certificate (User Key)

Create the file `config/initializers/crunchbase.rb` in your rails project and add user key.

    require 'crunchbase'

    Crunchbase::API.key = 'user_key'
    Crunchbase::API.debug = false
    Crunchbase::API.timeout = 60 # Default value is 60

### Creating request client

    client = Crunchbase::Client.new

### Searchable items

    - Organization
    - Person
    - Product
    - IPO
    - Acquisitions
    - Funding Rounds

#### Searching By...

    * client.search({query: "Google"}, 'organizations') # Full text search of an Organization's name, aliases
    * client.search({name: "Google"}, 'organizations') # Full text search limited to name and aliases
    * client.search({domain_name: "google.com"}, 'organizations') # Text search of an Organization's domain_name
    * client.search({locations: "China,Shanghai"}, 'organizations') # Filter by location names (comma separated, AND'd together)
    * client.search({name: "encore"}, 'people') # A full-text query of name only
    * client.search({query: "encore"}, 'people') # A full-text query of name, title, and company
    * client.search({types: "investor"}, 'people') # Filter by type (currently, either this is empty, or is simply "investor")
    * client.search({}, 'products')
    * client.search({}, 'ipos')
    * client.search({}, 'acquisitions')
    * client.search({}, 'funding-rounds')

    returned response included data on below:
        * results
        * total_items
        * per_page
        * pages
        * current_page

### Get Organization By The Permalink

    * response = client.get('facebook', 'Organization')

    - Relationship objects
        [
        primary_image founders current_team investors owned_by sub_organizations
        headquarters offices products categories customers competitors
        members memberships funding_rounds investments acquisitions acquired_by
        ipo funds websites images videos news
        ]

    - Methods: Get Organization with one relationship data
        * response = client.get('facebook', 'Organization', 'PastTeam')
        * past_team.results.collect { |p| [p.title, p.person.first_name] }

    ....

### Get Person By The Permalink

    => person = client.get(permalink, 'Person')
    => #<Crunchbase::Model::Person:0x007fc185215f68 @type_name="Person", @uuid="a578dcf9859ec8b52182e3aa3c383b13", ...>

    => people = client.list('Person', page: page)
    => people.results
    => [
        #<Crunchbase::Model::PersonSummary:...>,
        #<Crunchbase::Model::PersonSummary: ...>,
        #<Crunchbase::Model::PersonSummary: ...>,
        #<Crunchbase::Model::PersonSummary: ...>
        ......
    ]

### Batch Search
Pass in an array of requests to perform a batch search. Following parameters should be present in each request: `type`, `uuid` and `relationships` (https://data.crunchbase.com/docs/using-the-api#batch-search-capabilities).<br/>
Max 10 requests per search allowed.

    => requests = [
        { type: 'Organization', uuid: 'valid_uuid', relationships: ["<relationship_name>"] },
        { type: 'Person', uuid: 'valid_uuid', relationships: ["<relationship_name>"] },
        { type: 'Organization', uuid: 'invalid_uuid', relationships: [] },
    ]
    => batch_search = client.batch_search(requests)
    => batch_search = #<Crunchbase::Model::BatchSearch:0x007f9bd7e850d8 @results=[#<Crunchbase::Model::Organization:0x007f9bd7e84f98, ...>]>
    => batch_search.results
    => [
        #<Crunchbase::Model::Organization:0x007f9bd7e84f98, ...>,
        #<Crunchbase::Model::Person:0x007f9bda0d9d78, ...>,
        #<Crunchbase::Model::Error:0x007fd6b6818758 @code="LA404", @message="Not Found - Entity invalid_uuid doesn't exist" ...> // Error object returned due to invalid uuid passed
    ]


### How to debug in the console

    $ 1. ruby bin/console
    $ 2. ./bin/console
    => client = Crunchbase::Client.new
    => ...

### Contributing

1. Fork it ( https://github.com/encoreshao/crunchbase-ruby-library/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

### Copyright

Copyright © 2017-10 Encore Shao. See LICENSE for details.
