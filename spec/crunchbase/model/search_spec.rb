require File.join(File.dirname(__FILE__), "../..", "spec_helper.rb")

module Crunchbase
  module Model

    describe Search, "Search shouldn't be (get) method" do
      o = Search.get("abb")
      puts o.inspect
    end

    # Full text search of an Organization's name, 
    # aliases (i.e. previous names or "also known as"), and short description
    describe Search, "Search #query from crunchbase API" do
      o = Search.search({query: "Google"}, 'organizations')  


      o.results.each do |i|
        puts [i.name, i.permalink].inspect
      end
    end

    # Full text search limited to name and aliases
    describe Search, "Search #name from crunchbase API" do
      o = Search.search({name: "Google"}, 'organizations')  


      o.results.each do |i|
        puts [i.name, i.permalink].inspect
      end
    end

    # Text search of an Organization's domain_name (e.g. www.google.com)
    describe Search, "Search #domain_name from crunchbase API" do
      o = Search.search({domain_name: "google.com"}, 'organizations')  


      o.results.each do |i|
        puts [i.name, i.domain].inspect
      end
    end

  end
end