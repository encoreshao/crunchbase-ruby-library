require File.join(File.dirname(__FILE__), "../..", "spec_helper.rb")

module Crunchbase
  module Model

    describe Website, "#person_lists" do
      begin
        o = Website.person_lists("mark-zuckerberg").results

        o.collect {|e| puts e.website }

      rescue Exception => e
        puts e.message
      end
    end

  end
end