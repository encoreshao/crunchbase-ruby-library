require File.join(File.dirname(__FILE__), "../..", "spec_helper.rb")

module Crunchbase
  module Model

    describe Office, "#organization_lists" do
      begin
        results = Office.organization_lists("facebook").results
        results.collect {|e| puts e.name }

      rescue Exception => e
        puts e.message
      end
    end

  end
end