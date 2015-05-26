require File.join(File.dirname(__FILE__), "../..", "spec_helper.rb")

module Crunchbase
  module Model

    describe PastTeam do

      before(:all) do
        begin
          @past_team = PastTeam.organization_lists("apple2")
        rescue Exception => e
          @past_team = nil
        end
      end

      it 'show past team results' do
        unless @past_team.nil?
          puts @past_team.total_items

          puts @past_team.results.collect { |p| [p.title, p.person.first_name] }.inspect
        end
      end

    end
  end
end