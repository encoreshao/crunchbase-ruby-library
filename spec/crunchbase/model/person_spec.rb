require File.join(File.dirname(__FILE__), "../..", "spec_helper.rb")

module Crunchbase
  module Model

    # describe Person, "#get" do
    #   begin
    #     person = Person.get("li-ka-shing")

    #     puts person.inspect

    #   rescue Exception => e
    #     puts e.message
    #   end
    # end

    describe Person, "#list" do
      begin
        person = Person.list( 1 )
        puts person.results.map {|e| [e.first_name, e.last_name].join(', ') }.inspect
      rescue Exception => e
        puts e.message
      end
    end
  end
end
