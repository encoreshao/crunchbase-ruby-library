require File.join(File.dirname(__FILE__), "../..", "spec_helper.rb")

module Crunchbase
  module Model

    # Full text search of an Organization's name, 
    # aliases (i.e. previous names or "also known as"), and short description
    describe Search, "Search organizations with -> query through crunchbase API" do
      o = Search.search({query: "Google"}, 'organizations')  


      o.results.each do |i|
        puts [i.name, i.permalink].inspect
      end
    end

    # Full text search limited to name and aliases
    describe Search, "Search organizations with -> name through crunchbase API" do
      o = Search.search({name: "Google"}, 'organizations')  


      o.results.each do |i|
        puts [i.name, i.permalink].inspect
      end
    end

    # Text search of an Organization's domain_name (e.g. www.google.com)
    describe Search, "Search organizations with -> domain_name through crunchbase API" do
      o = Search.search({domain_name: "google.com"}, 'organizations')  


      o.results.each do |i|
        puts [i.name, i.domain].inspect
      end
    end

    # A full-text query of name, title, and company
    describe Search, "Search person with -> query through crunchbase API" do
      o = Search.search({query: "encore"}, 'people')  


      o.results.each do |i|
        puts [i.first_name, i.last_name].inspect
      end
    end



  end
end