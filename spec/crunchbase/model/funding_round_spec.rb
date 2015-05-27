require File.join(File.dirname(__FILE__), "../..", "spec_helper.rb")

module Crunchbase
  module Model

    describe FundingRound, "#get" do
      round = FundingRound.get('c31e2cc41e8f30c6da0aaf6b395469e5')
      
      puts round.inspect
    end

    describe FundingRound, "#organization_lists" do
      begin
        results = FundingRound.organization_lists("xiaomi").results
        results.collect {|e| puts e.funding_type }

      rescue Exception => e
        puts e.message
      end
    end

    describe FundingRound, "get news" do
      news = New.funding_rounds_lists('c31e2cc41e8f30c6da0aaf6b395469e5').results
      puts news.map {|e| e.title }
    end


    describe FundingRound, "get images" do
      images = Image.funding_rounds_lists('c31e2cc41e8f30c6da0aaf6b395469e5').results
      puts images.map {|e| e.inspect }
    end

    describe FundingRound, "get investments" do
      investments = Investment.funding_rounds_lists('c31e2cc41e8f30c6da0aaf6b395469e5').results
      puts investments.map {|e| e.inspect }
    end

  end
end