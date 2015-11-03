require File.join(File.dirname(__FILE__), "../..", "spec_helper.rb")

module Crunchbase
  module Model

    describe Organization do

      context "organization with i18n name" do
        before(:all) do
          @organization = Organization.get("bon-appétit")
        end

        it 'returns organization data' do
          expect(@organization.name).to eq("Bon Appétit")
        end
      end

      context "TODO" do
        before(:all) do
          @organization = Organization.get("abovenet")  
        end

        it 'show all products name' do
          puts @organization.products.map { |i| i.name }.inspect unless @organization.products.nil?
        end

        it 'show all offices name' do
          puts @organization.offices.map { |i| i.name }.inspect unless @organization.offices.nil?
        end

        it 'show all funding_rounds funding_type' do
          puts @organization.funding_rounds.map { |i| i.funding_type }.inspect unless @organization.funding_rounds.nil?
        end

        it 'show all competitors name' do
          puts @organization.competitors.map { |i| i.name }.inspect unless @organization.competitors.nil?
        end

        it 'show all investments money_invested' do
          puts @organization.investments.map { |i| i.money_invested }.inspect unless @organization.investments.nil?
        end

        it 'show all acquisitions acquiree name' do
          puts @organization.acquisitions.map { |i| i.acquiree.name }.inspect unless @organization.acquisitions.nil?
        end

        it 'show all ipo funded_company name' do
          puts "IPOs - #{@organization.ipo_total_items.nil?}"
          puts @organization.ipo.map { |i| i.funded_company.name }.inspect unless @organization.ipo.nil?
        end

        it "show all categories name" do 
          puts @organization.categories.map {|i| i.name }.inspect unless @organization.categories.nil?
        end

        it "show all news name" do 
          puts @organization.news.map {|i| i.title }.inspect unless @organization.news.nil?
        end

        it "show all current_team members name" do
          puts @organization.current_team.map {|i| [i.title, i.person.last_name] }.inspect unless @organization.current_team.nil?
        end

        it "show all websites website" do
          puts @organization.websites.map {|i| i.website }.inspect unless @organization.websites.nil?
        end
      end

    end

  end
end
