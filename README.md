# Crunchbase

Crunchbase API v3.1 - Ruby Library [CrunchBase Data Hub](https://data.crunchbase.com/v3.1/docs/using-the-api).

[![Build Status](https://travis-ci.org/encoreshao/crunchbase-ruby-library.svg?branch=master)](https://travis-ci.org/encoreshao/crunchbase-ruby-library)
[![Coverage Status](https://coveralls.io/repos/github/encoreshao/crunchbase-ruby-library/badge.svg)](https://coveralls.io/github/encoreshao/crunchbase-ruby-library)

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

## Search Organization OR Person OR Product OR IPO OR Acquisitions OR Funding Rounds

Retrieve the way, Please use Search Class. The Search Will Return a list consisting of objects of the OrganizationSummary | PersonSummary | ProductSummary | Funding Rounds type. Example:

    Query Orgnization

    Method 1
    response = Crunchbase::Model::Search.search({query: "Google"}, 'organizations')

    Method 2
    response = Crunchbase::Model::Search.search({name: "Google"}, 'organizations')

    Method 3
    response = Crunchbase::Model::Search.search({domain_name: "google.com"}, 'organizations')

    response.total_items || response.per_page || response.pages || response.current_page
    response.results.each { |r| puts r.name }


    Query Person

    response = Crunchbase::Model::Search.search({query: "encore"}, 'people')

    response.results.each { |i| [i.first_name, i.last_name] }

    Query Product

    response = Crunchbase::Model::Search.search({}, 'products')

    response.results.each { |i| i.name }

    Query IPO

    response = Crunchbase::Model::Search.search({}, 'ipos')

    response.results.each { |i| i.name }

    Query Acquisition

    response = Crunchbase::Model::Search.search({}, 'acquisitions')

    Funding Rounds

    response = Crunchbase::Model::Search.search({}, 'funding-rounds')

## Get Organization && RelationShips

Get information by the permalink, Example:

    response = Crunchbase::Model::Organization.get("facebook")

    Relationship objects [ primary_image founders current_team investors owned_by sub_organizations headquarters offices products categories customers competitors members memberships funding_rounds investments acquisitions acquired_by ipo funds websites images videos news ]

    response.founders
    response.competitors_total_items
    response.websites

    NOTE: If you want all `past_team` `board_members_and_advisors` items, Please do:

    # Methods

    past_team = Crunchbase::Model::PastTeam.organization_lists("facebook")
    past_team.results.collect { |p| [p.title, p.person.first_name] }

    ....

## Person

Get information by the permalink, Example:

    person = Crunchbase::Model::Person.get( permalink )

    #<Crunchbase::Model::Person:0x007fc185215f68 @type_name="Person", @uuid="a578dcf9859ec8b52182e3aa3c383b13", ...>

    people = Crunchbase::Model::Person.list( page )

    people.results

    [ #<Crunchbase::Model::PersonSummary:...>,
    #<Crunchbase::Model::PersonSummary: ...>,
    #<Crunchbase::Model::PersonSummary: ...>,
    #<Crunchbase::Model::PersonSummary: ...>
    ...... ]

## Contributing

1. Fork it ( https://github.com/encoreshao/crunchbase-ruby-library/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Copyright

Copyright © 2015-05 Encore Shao. See LICENSE for details.
