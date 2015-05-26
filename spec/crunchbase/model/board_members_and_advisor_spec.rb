require File.join(File.dirname(__FILE__), "../..", "spec_helper.rb")

module Crunchbase
  module Model

    describe BoardMembersAndAdvisor do
      begin
        o = BoardMembersAndAdvisor.organization_lists("apple")
    
        puts o.total_items

        o.results.collect { |p| puts p.person.first_name }

      rescue Exception => e
        puts e.message
      end
    end

  end
end