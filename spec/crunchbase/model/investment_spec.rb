require File.join(File.dirname(__FILE__), "../..", "spec_helper.rb")

module Crunchbase
  module Model

    describe Investment, "#organization_lists" do
      begin
        results = Investment.organization_lists("stripes-group").results
        results.collect {|e| puts e.inspect }

      rescue Exception => e
        puts e.message
      end
    end

  end
end