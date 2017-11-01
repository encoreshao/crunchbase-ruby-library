# frozen_string_literal: true

module Crunchbase
  module Model
    RSpec.describe Office do
      let(:offices_data) { parse_json('offices', 'facebook') }

      context 'offices of facebook' do
        let(:offices) { Office.organization_lists('facebook') }

        before :each do
          result = search_results(offices_data, Office)

          allow(Office).to receive(:organization_lists).and_return(result)
        end

        it 'should return 1 of total count with offices' do
          expect(offices.results.size).to eq(1)
        end

        it 'should paging values from offices response' do
          expect(offices.pages).to eq(1)
          expect(offices.current_page).to eq(1)
          expect(offices.per_page).to eq(100)
        end

        it 'should return first office record' do
          first_item = offices.results.first

          expect(first_item.type_name).to eq('Address')
          expect(first_item.uuid).to eq('daebcfe0115c38af678c04603cc9f00f')
          expect(first_item.name).to eq('Headquarters')
        end
      end
    end
  end
end
