# frozen_string_literal: true

module Crunchbase
  module Model
    RSpec.describe Website do
      let(:websites_data) { parse_json('websites', 'facebook') }

      context 'websites of facebook' do
        let(:websites) { Website.organization_lists('facebook') }

        before :each do
          result = search_results(websites_data, Website)

          allow(Website).to receive(:organization_lists).and_return(result)
        end

        it 'should return 4 of total count with websites' do
          expect(websites.results.size).to eq(4)
        end

        it 'should paging values from websites response' do
          expect(websites.pages).to eq(1)
          expect(websites.current_page).to eq(1)
          expect(websites.per_page).to eq(100)
        end

        it 'should return first website record' do
          first_item = websites.results.first

          expect(first_item.type_name).to eq('Website')
          expect(first_item.website_type).to eq('homepage')
          expect(first_item.website_type).to eq('homepage')
        end

        it 'should return last website record' do
          first_item = websites.results.last

          expect(first_item.type_name).to eq('Website')
          expect(first_item.website_name).to eq('linkedin')
          expect(first_item.website_type).to eq('linkedin')
        end
      end
    end
  end
end
