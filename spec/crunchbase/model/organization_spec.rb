require File.join(File.dirname(__FILE__), "../..", "spec_helper.rb")

module Crunchbase
  module Model

    describe Organization, "#search - domain_name" do
      # o = Organization.search({ domain_name: 'ekohe.com' })

      # o.results.each do |t|
      #   puts t.inspect
      # end
    end
    describe Organization, "#search - name" do
      o = Organization.search({ name: 'abb' })

      puts o.results.map {|e| e.permalink }
    end

    describe Organization, "#get" do
      # subject { Organization.get("xiaomi") }

      # its(:name) { should eq('Xiaomi') }
      # its(:investors_total_items) { should eq(7) }
      # its(:current_team_total_items) { should eq(10) }
      # its(:offices_total_items) { should eq(1) }
      # its(:investments_total_items) { should eq(13) }
      
      # o = Organization.get("abb")  

      # puts o.inspect

      # o.current_team.each do |p|
      #   puts p.person.inspect
      # end

    end

  end
end