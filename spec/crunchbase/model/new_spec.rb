# frozen_string_literal: true

module Crunchbase
  module Model
    RSpec.describe New do
      let(:news_data) { parse_json('news', 'facebook') }
      let(:page2_news_data) { parse_json('news', 'facebook_2') }

      context 'news of facebook' do
        let(:news) { New.organization_lists('facebook') }

        before :each do
          result = search_results(news_data, New)

          allow(New).to receive(:organization_lists).and_return(result)
        end

        it 'should return 100 of total count with news' do
          expect(news.results.size).to eq(100)
        end

        it 'should paging values from news response' do
          expect(news.pages).to eq(2632)
          expect(news.current_page).to eq(1)
          expect(news.per_page).to eq(100)
        end

        it 'should return first news record' do
          first_item = news.results.first

          expect(first_item.type_name).to eq('News')
          expect(first_item.uuid).to eq('527114a5b61a44989480eea5c4452800')
          expect(first_item.author).to eq('Anthony Ha')
          expect(first_item.title).to eq('Facebook says its ad transparency features will go live next month')
        end

        it 'should return last news record' do
          first_item = news.results.last

          expect(first_item.type_name).to eq('News')
          expect(first_item.uuid).to eq('36474c1cd9acfc2717e1974fbc7f1bdb')
          expect(first_item.author).to eq('Natasha Lomas')
          expect(first_item.title).to eq('Teens favoring Snapchat and Instagram over Facebook, says eMarketer')
        end
      end

      context 'the second page news of facebook' do
        let(:page2_news) { New.organization_lists('facebook', {page: 2}) }

        before :each do
          result = search_results(page2_news_data, New)

          allow(New).to receive(:organization_lists).and_return(result)
        end

        it 'should return 100 of total count with news' do
          expect(page2_news.results.size).to eq(100)
        end

        it 'should paging values from news response' do
          expect(page2_news.pages).to eq(2632)
          expect(page2_news.current_page).to eq(2)
          expect(page2_news.per_page).to eq(100)
        end

        it 'should return first news record' do
          first_item = page2_news.results.first

          expect(first_item.type_name).to eq('News')
          expect(first_item.uuid).to eq('36474c1cd9acfc2717e1974fbc7f1bdb')
          expect(first_item.author).to eq('Natasha Lomas')
          expect(first_item.title).to eq('Teens favoring Snapchat and Instagram over Facebook, says eMarketer')
        end

        it 'should return last news record' do
          first_item = page2_news.results.last

          expect(first_item.type_name).to eq('News')
          expect(first_item.uuid).to eq('21d29affc387006838577aba6e214430')
          expect(first_item.author).to eq('Josh Constine')
          expect(first_item.title).to eq('Facebook Messenger globally tests injecting display ads into inbox')
        end
      end
    end
  end
end
