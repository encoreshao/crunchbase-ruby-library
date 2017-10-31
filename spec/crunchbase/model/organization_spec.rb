# frozen_string_literal: true

module Crunchbase
  module Model
    RSpec.describe Organization do
      let(:without_relationship_json_data) { parse_json('organizations', 'facebook-without-relationships') }
      let(:with_relationship_json_data) { parse_json('organizations', 'facebook') }

      context 'facebook without relationships data' do
        let(:without_organization) { Organization.get('facebook') }

        before :each do
          result = Organization.new(without_relationship_json_data)

          allow(Organization).to receive(:get).and_return(result)
        end

        it 'should return facebook and Facebook from API' do
          expect(without_organization.permalink).to eq('facebook')
          expect(without_organization.name).to eq('Facebook')
        end

        it 'should return nil when without relationships' do
          expect(without_organization.products.nil?).to be_truthy
          expect(without_organization.offices.nil?).to be_truthy
          expect(without_organization.headquarters.nil?).to be_truthy
          expect(without_organization.funding_rounds.nil?).to be_truthy
          expect(without_organization.competitors.nil?).to be_truthy
          expect(without_organization.investments.nil?).to be_truthy
          expect(without_organization.acquisitions.nil?).to be_truthy
          expect(without_organization.ipo.nil?).to be_truthy
          expect(without_organization.categories.nil?).to be_truthy
          expect(without_organization.news.nil?).to be_truthy
          expect(without_organization.current_team.nil?).to be_truthy
          expect(without_organization.websites.nil?).to be_truthy
          expect(without_organization.founders.nil?).to be_truthy
        end
      end

      context 'facebook with relationships data' do
        let(:organization) { Organization.get('facebook') }

        before :each do
          result = Organization.new(with_relationship_json_data)

          allow(Organization).to receive(:get).and_return(result)
        end

        it 'should return facebook and Facebook from API' do
          expect(organization.permalink).to eq('facebook')
          expect(organization.name).to eq('Facebook')
        end

        it 'should return one primary_image' do
          expect(organization.primary_image.nil?).to be_falsy
          expect(organization.primary_image_total_items).to eq(1)
        end

        it 'should return 0 of products and competitors' do
          expect(organization.products.size).to eq(0)
          expect(organization.competitors.size).to eq(0)
        end

        it 'should return 1 of offices - OneToOne' do
          expect(organization.offices.class).to eq(Office)
          expect(organization.offices.nil?).to be_falsy
        end

        it 'should return 1 of headquarters - OneToOne' do
          expect(organization.headquarters.class).to eq(Headquarter)
          expect(organization.headquarters.nil?).to be_falsy
        end

        it 'should return 10 of funding_rounds' do
          expect(organization.funding_rounds.size).to eq(10)
        end

        it 'should return 9 of investments' do
          expect(organization.investments.size).to eq(9)
        end

        it 'should return 10 of acquisitions' do
          expect(organization.acquisitions.size).to eq(10)
        end

        it 'should return ipo relationship' do
          expect(organization.ipo.nil?).to be_falsy
        end

        it 'should return 3 of categories' do
          expect(organization.categories.size).to eq(3)
        end

        it 'should return 0 of videos' do
          expect(organization.videos.size).to eq(0)
          expect(organization.videos_total_items).to eq(0)
        end

        it 'should return 10 of news' do
          expect(organization.news.size).to eq(10)
          expect(organization.news_total_items).to eq(263155)
        end

        it 'should return 10 of current_team' do
          expect(organization.current_team.size).to eq(10)
        end

        it 'should return 4 of websites' do
          expect(organization.websites.size).to eq(4)
        end

        it 'should return 10 of investors item and total pages count 20' do
          expect(organization.investors.size).to eq(10)
          expect(organization.investors_total_items).to eq(20)
        end

        it 'should return 5 of founders' do
          expect(organization.founders.size).to eq(5)
        end
      end
    end
  end
end
