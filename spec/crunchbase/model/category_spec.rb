require File.join(File.dirname(__FILE__), "../..", "spec_helper.rb")

module Crunchbase
  module Model

    describe Category, "#list" do
      before(:all) do
        begin
          @categories = Category.list.results
        rescue Exception => e
          @categories = nil
        end
      end

      it "returns results" do
        puts @categories.collect { |c| c.name }
      end
    end
  end
end
