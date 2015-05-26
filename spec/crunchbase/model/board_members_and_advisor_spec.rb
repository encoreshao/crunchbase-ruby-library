require File.join(File.dirname(__FILE__), "../..", "spec_helper.rb")

module Crunchbase
  module Model

    describe BoardMembersAndAdvisor do
      o = BoardMembersAndAdvisor.organization_lists("apple")
 
      o.results.each do |p|
        puts p.person.inspect
      end
    end

  end
end