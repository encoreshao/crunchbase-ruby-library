require File.join(File.dirname(__FILE__), "../..", "spec_helper.rb")

module Crunchbase
  module Model

    describe FundRaise do

      before(:all) do
        begin
          @funds = FundRaise.organization_lists("apple")
        rescue Exception => e
          @funds = nil
        end
      end

      it 'show funds results' do
        unless @funds.nil?
          puts @funds.total_items

          puts @funds.results.collect { |p| [p.name] }.inspect
        end
      end

    end
  end
end