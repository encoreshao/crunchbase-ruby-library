# encoding: utf-8
# frozen_string_literal: true

module Crunchbase
  module Model
    describe Organization do
      let(:without_relationship_json_data) { parse_json('organizations', 'facebook-without-relationships') }
      let(:with_relationship_json_data) { parse_json('organizations', 'facebook') }

      context 'facebook without relationships data' do
        let(:without_organization) { Organization.get('facebook') }

        before :each do
          result = Organization.new(without_relationship_json_data)

          allow(Organization).to receive(:get).and_return(result)
        end

        it 'should return facebook as name from API' do
          expect(without_organization.name).to eq('Facebook')
        end

        it 'should return facebook as permalink from API' do
          expect(without_organization.permalink).to eq('facebook')
        end

        it 'should return nil when without products relationships' do
          expect(without_organization.products.nil?).to be_truthy
        end

        it 'should return nil when without offices relationships' do
          expect(without_organization.offices.nil?).to be_truthy
        end

        it 'should return nil when without funding_rounds relationships' do
          expect(without_organization.funding_rounds.nil?).to be_truthy
        end

        it 'should return nil when without competitors relationships' do
          expect(without_organization.competitors.nil?).to be_truthy
        end

        it 'should return nil when without investments relationships' do
          expect(without_organization.investments.nil?).to be_truthy
        end

        it 'should return nil when without acquisitions relationships' do
          expect(without_organization.acquisitions.nil?).to be_truthy
        end

        it 'should return nil when without ipo relationships' do
          expect(without_organization.ipo.nil?).to be_truthy
        end

        it 'should return nil when without categories relationships' do
          expect(without_organization.categories.nil?).to be_truthy
        end

        it 'should return nil when without news relationships' do
          expect(without_organization.news.nil?).to be_truthy
        end

        it 'should return nil when without current_team relationships' do
          expect(without_organization.current_team.nil?).to be_truthy
        end

        it 'should return nil when without websites relationships' do
          expect(without_organization.websites.nil?).to be_truthy
        end
      end
      context 'facebook with relationships data' do
        let(:organization) { Organization.get('facebook') }

        before :each do
          result = Organization.new(with_relationship_json_data)

          allow(Organization).to receive(:get).and_return(result)
        end

        it 'should return facebook as name from API' do
          expect(organization.name).to eq('Facebook')
        end

        it 'should return facebook as permalink from API' do
          expect(organization.permalink).to eq('facebook')
        end

        it 'should return 0 of products' do
          expect(organization.products.size).to eq(0)
        end

        it 'should return 1 of offices - OneToOne' do
          expect(organization.offices.class).to eq(Office)
          expect(organization.offices.nil?).to be_falsy
        end

        it 'should return 10 of funding_rounds' do
          expect(organization.funding_rounds.size).to eq(10)
        end

        it 'should return 0 of competitors' do
          expect(organization.competitors.size).to eq(0)
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

        it 'should return 10 of news' do
          expect(organization.news.size).to eq(10)
        end

        it 'should return 10 of current_team' do
          expect(organization.current_team.size).to eq(10)
        end

        it 'should return 10 of websites' do
          expect(organization.websites.size).to eq(4)
        end
      end
    end
  end
end
