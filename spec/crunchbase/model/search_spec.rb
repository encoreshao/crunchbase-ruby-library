require File.join(File.dirname(__FILE__), "../..", "spec_helper.rb")

module Crunchbase
  module Model

    describe Search, "search in crunchbase" do
      o = Search.get("abb")  
    end

  end
end