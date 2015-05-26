require File.join(File.dirname(__FILE__), "../..", "spec_helper.rb")

module Crunchbase
  module Model

    describe Person, "#search - query" do
      # o = Person.search({ query: 'maxime' })

      # puts o.results.map {|e| e.inspect }
    end

    describe Person, "#get" do
      o = Person.get("li-ka-shing")

      # puts o.primary_image.inspect

      o.news.each do |j|
        puts j.inspect
      end
    end

  end
end