# frozen_string_literal: true

module Crunchbase
  module Model
    RSpec.describe FundingRound do
      let(:funding_rounds_data) { parse_json('funding_rounds', 'facebook') }

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
    end
  end
end
