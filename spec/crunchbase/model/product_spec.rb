require File.join(File.dirname(__FILE__), "../..", "spec_helper.rb")

module Crunchbase
  module Model

    describe Product, "#get" do
      begin
        ps = Product.get("hiphop-virtual-machine")

        puts ps.inspect

      rescue Exception => e
        puts e.message
      end
    end

    describe Product, "#organization_lists" do
      # begin
      #   ps = Product.organization_lists("facebook")

      #   puts ps.total_items

      #   ps.results.each do |p|
      #     puts [p.permalink, p.name].inspect
      #   end

      # rescue Exception => e
      #   puts e.message
      # end
    end

  end
end