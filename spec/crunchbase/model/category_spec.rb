# frozen_string_literal: true

module Crunchbase
  module Model
    RSpec.describe Category do
      let(:categories_data) { parse_json('categories', 'facebook') }

      context 'categories of facebook' do
        let(:categories) { Category.organization_lists('facebook') }

        before :each do
          result = search_results(categories_data, Category)

          allow(Category).to receive(:organization_lists).and_return(result)
        end

        it 'should return 4 of total count with categories' do
          expect(categories.results.size).to eq(3)
        end

        it 'should paging values from categories response' do
          expect(categories.pages).to eq(1)
          expect(categories.current_page).to eq(1)
          expect(categories.per_page).to eq(100)
        end

        it 'should return first website record' do
          first_item = categories.results.first

          expect(first_item.type_name).to eq('Category')
          expect(first_item.uuid).to eq('5349a2f214d89727c32a19ebea5db78c')
          expect(first_item.name).to eq('Social Media')
          expect(first_item.web_path).to eq('category/social-media/5349a2f214d89727c32a19ebea5db78c')
        end

        it 'should return last website record' do
          first_item = categories.results.last

          expect(first_item.type_name).to eq('Category')
          expect(first_item.uuid).to eq('80de9bf4789eb80e051cdc079493803f')
          expect(first_item.name).to eq('Social')
          expect(first_item.web_path).to eq('category/social/80de9bf4789eb80e051cdc079493803f')
        end
      end
    end
  end
end
