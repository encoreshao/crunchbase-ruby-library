# frozen_string_literal: true

module Crunchbase
  module Model
    RSpec.describe Investor do
      let(:investors_data) { parse_json('investors', 'facebook') }

      context 'investors of facebook' do
        let(:investors) { Investor.organization_lists('facebook') }

        before :each do
          result = search_results(investors_data, Investor)

          allow(Investor).to receive(:organization_lists).and_return(result)
        end

        it 'should return 11 of total count with investors' do
          expect(investors.results.size).to eq(20)
        end

        it 'should paging values from investors response' do
          expect(investors.pages).to eq(1)
          expect(investors.current_page).to eq(1)
          expect(investors.per_page).to eq(100)
        end

        it 'should return first investors record' do
          first_item = investors.results.first

          expect(first_item.object.uuid).to eq('0159561fbe5d81eb7ccdb4d6efeb30fc')
          expect(first_item.object.type_name).to eq('Person')
          expect(first_item.object.permalink).to eq('mark-pincus')
        end
      end
    end
  end
end
