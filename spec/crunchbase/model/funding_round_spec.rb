# frozen_string_literal: true

module Crunchbase
  module Model
    RSpec.describe FundingRound do
      let(:funding_rounds_data) { parse_json('funding_rounds', 'facebook') }
      let(:funding_round_data) { parse_json('funding_rounds', '37bd05f961af726ba3c1b279da842805') }

      context 'funding_rounds of facebook' do
        let(:funding_rounds) { FundingRound.organization_lists('facebook') }

        before :each do
          result = search_results(funding_rounds_data, FundingRound)

          allow(FundingRound).to receive(:organization_lists).and_return(result)
        end

        it 'should paging values from funding_rounds response' do
          expect(funding_rounds.pages).to eq(1)
          expect(funding_rounds.current_page).to eq(1)
          expect(funding_rounds.per_page).to eq(100)
        end

        it 'should return 11 of total count with funding_rounds' do
          expect(funding_rounds.results.size).to eq(11)
          expect(funding_rounds.total_items).to eq(11)
        end

        it 'should return first funding_round record' do
          first_item = funding_rounds.results.first

          expect(first_item.uuid).to eq('37bd05f961af726ba3c1b279da842805')
          expect(first_item.type_name).to eq('FundingRound')
        end
      end

      context 'funding_round of facebook' do
        let(:funding_round) { FundingRound.get('37bd05f961af726ba3c1b279da842805') }

        before :each do
          result = FundingRound.new(funding_round_data)

          allow(FundingRound).to receive(:get).and_return(result)
        end

        it 'should return current founding round record uuid' do
          expect(funding_round.uuid).to eq('37bd05f961af726ba3c1b279da842805')
        end

        it 'should return 2 investments records of founding round' do
          expect(funding_round.investments.size).to eq(2)
          expect(funding_round.investments_total_items).to eq(2)
        end

        it 'should return the first investment of founding round' do
          first_investment = funding_round.investments[0]

          expect(first_investment.investors.nil?).to be_falsy
          expect(first_investment.investors.name).to eq('DST Global')
          expect(first_investment.investors.permalink).to eq('digital-sky-technologies-fo')
        end

        it 'should return 2 investors of founding round' do
          expect(funding_round.investors.size).to eq(2)
          expect(funding_round.investors_total_items).to eq(2)
        end

        it 'should return funded organization of funding_round' do
          expect(funding_round.funded_organization.nil?).to be_falsy
          expect(funding_round.funded_organization.name).to eq('Facebook')
          expect(funding_round.funded_organization.permalink).to eq('facebook')
        end

        it 'should return 0 images and 0 videos of funding_round' do
          expect(funding_round.images.size).to eq(0)
          expect(funding_round.images_total_items).to eq(0)
          expect(funding_round.videos.size).to eq(0)
          expect(funding_round.videos_total_items).to eq(0)
        end

        it 'should return 2 news of funding_round' do
          expect(funding_round.news.size).to eq(2)
          expect(funding_round.news_total_items).to eq(2)
        end
      end
    end
  end
end
