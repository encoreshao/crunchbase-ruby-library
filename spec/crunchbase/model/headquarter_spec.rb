# frozen_string_literal: true

module Crunchbase
  module Model
    RSpec.describe Headquarter do
      let(:headquarters_data) { parse_json('headquarters', 'facebook') }

      context 'headquarters of facebook' do
        let(:headquarters) { Headquarter.organization_lists('facebook') }

        before :each do
          result = search_results(headquarters_data, Headquarter)

          allow(Headquarter).to receive(:organization_lists).and_return(result)
        end

        it 'should return 1 of total count with headquarters' do
          expect(headquarters.results.size).to eq(1)
        end

        it 'should paging values from headquarters response' do
          expect(headquarters.pages).to eq(1)
          expect(headquarters.current_page).to eq(1)
          expect(headquarters.per_page).to eq(100)
        end

        it 'should return first office record' do
          first_item = headquarters.results.first

          expect(first_item.type_name).to eq('Address')
          expect(first_item.uuid).to eq('daebcfe0115c38af678c04603cc9f00f')
          expect(first_item.name).to eq('Headquarters')
        end
      end
    end
  end
end
