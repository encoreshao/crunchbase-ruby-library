require File.join(File.dirname(__FILE__), "../..", "spec_helper.rb")

module Crunchbase
  module Model

    describe Organization do
      subject { Organization.get("xiaomi") }

      its(:name) { should eq('Xiaomi') }
      its(:investors_total_items) { should eq(7) }
      its(:current_team_total_items) { should eq(10) }
      its(:offices_total_items) { should eq(1) }
    end

  end
end