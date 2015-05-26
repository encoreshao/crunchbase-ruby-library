require File.join(File.dirname(__FILE__), "../..", "spec_helper.rb")

module Crunchbase
  module Model

    describe Organization do

      before(:all) do
        @organization = Organization.get("facebook")  
      end

      it 'show all products name' do
        puts @organization.products.map { |i| i.name }.inspect
      end

      it 'show all offices name' do
        puts @organization.offices.map { |i| i.name }.inspect
      end

      it 'show all funding_rounds funding_type' do
        puts @organization.funding_rounds.map { |i| i.funding_type }.inspect
      end

      it 'show all competitors name' do
        puts @organization.competitors.map { |i| i.name }.inspect
      end

      it 'show all investments money_invested' do
        puts @organization.investments.map { |i| i.money_invested }.inspect
      end

      it 'show all acquisitions acquiree name' do
        puts @organization.acquisitions.map { |i| i.acquiree.name }.inspect
      end

      it 'show all ipo funded_company name' do
        puts "IPOs - #{@organization.ipo_total_items.nil?}"
        puts @organization.ipo.map { |i| i.funded_company.name }.inspect unless @organization.ipo.nil?
      end

      it "show all categories name" do 
        puts @organization.categories.map {|i| i.name }.inspect
      end

      it "show all news name" do 
        puts @organization.news.map {|i| i.title }.inspect
      end

      it "show all current_team members name" do
        puts @organization.current_team.map {|i| [i.title, i.person.last_name] }.inspect
      end

      it "show all websites website" do
        puts @organization.websites.map {|i| i.website }.inspect
      end

    end

  end
end