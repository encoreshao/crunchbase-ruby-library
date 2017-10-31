# frozen_string_literal: true

module Crunchbase
  module Model
    RSpec.describe Founder do
      let(:founders_data) { parse_json('people', 'facebook_founders') }

      context 'founders of facebook' do
        let(:founders) { Founder.organization_lists('facebook') }

        before :each do
          result = search_results(founders_data, Founder)

          allow(Founder).to receive(:organization_lists).and_return(result)
        end

        it 'should return 5 of total count with founders' do
          expect(founders.results.size).to eq(5)
        end

        it 'should paging values from founders response' do
          expect(founders.pages).to eq(1)
          expect(founders.current_page).to eq(1)
          expect(founders.per_page).to eq(100)
        end

        it 'should return first founder record' do
          first_item = founders.results.first

          expect(first_item.type_name).to eq('Person')
          expect(first_item.uuid).to eq('084aaa0707951fe89c4698bbeb02cd64')
          expect(first_item.first_name).to eq('Dustin')
          expect(first_item.last_name).to eq('Moskovitz')
          expect(first_item.web_path).to eq('person/dustin-moskovitz')
        end

        it 'should return last founder record' do
          first_item = founders.results.last

          expect(first_item.type_name).to eq('Person')
          expect(first_item.uuid).to eq('fb5b458c0aaba97771b9ecf78d3ec756')
          expect(first_item.first_name).to eq('Eduardo')
          expect(first_item.last_name).to eq('Saverin')
          expect(first_item.web_path).to eq('person/eduardo-saverin')
        end
      end
    end
  end
end
