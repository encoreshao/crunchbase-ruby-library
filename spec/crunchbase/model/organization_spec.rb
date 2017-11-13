# frozen_string_literal: true

# disabled ModuleLength
module Crunchbase
  module Model
    RSpec.describe Organization do
      let(:without_relationship_json_data) { parse_json('organizations', 'facebook-without-relationships') }
      let(:with_relationship_json_data) { parse_json('organizations', 'facebook') }
      let(:ekohe_data) { parse_json('organizations', 'ekohe') }

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
          expect(without_organization.past_team.nil?).to be_truthy
          expect(without_organization.board_members_and_advisors.nil?).to be_truthy
          expect(without_organization.featured_team.nil?).to be_truthy
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

        it 'should return 10 of investments' do
          expect(organization.investments.size).to eq(10)
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
          expect(organization.news_total_items).to eq(263177)
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

        it 'should return 10 of past_team and total 420 of past team' do
          expect(organization.past_team_total_items).to eq(420)
          expect(organization.past_team.size).to eq(10)
        end

        it 'should return the first past_team information' do
          first_member = organization.past_team[0]

          expect(first_member.title).to eq('Software Engineer')
          expect(first_member.uuid).to eq('009b372b0ee6bf03f60346b3a1730f41')
          expect(first_member.person.first_name).to eq('Perry')
          expect(first_member.person.last_name).to eq('Tam')
          expect(first_member.person.permalink).to eq('perry-tam')
        end

        it 'should return 10 of board_members_and_advisors' do
          expect(organization.board_members_and_advisors_total_items).to eq(10)
          expect(organization.board_members_and_advisors.size).to eq(10)
        end

        it 'should return 6 of featured_team' do
          expect(organization.featured_team_total_items).to eq(6)
          expect(organization.featured_team.size).to eq(6)
        end

        context 'funding_rounds' do
          it 'should return correctly data of the first funding round' do
            first_funding_round = organization.funding_rounds[0]

            expect(first_funding_round.uuid).to eq('37bd05f961af726ba3c1b279da842805')
            expect(first_funding_round.funding_type).to eq('private_equity')
            expect(first_funding_round.announced_on).to eq(Date.parse('2011-01-21'))
            expect(first_funding_round.money_raised_currency_code).to eq('USD')
            expect(first_funding_round.money_raised).to eq(1500000000)
            expect(first_funding_round.money_raised_usd).to eq(1500000000)
            expect(first_funding_round.investments.size).to eq(2)

            expect(first_funding_round.investments[0].investors.name).to eq('DST Global')
            expect(first_funding_round.investments[0].partners.size).to eq(1)
          end
        end
      end

      context 'ekohe data' do
        let(:ekohe) { Organization.get('ekohe') }

        before :each do
          result = Organization.new(ekohe_data)

          allow(Organization).to receive(:get).and_return(result)
        end

        it 'should return ekohe information' do
          expect(ekohe.name).to eq('Ekohe')
          expect(ekohe.permalink).to eq('ekohe')
        end

        it 'should return ekohe relationships data' do
          expect(ekohe.acquired_by.nil?).to be_truthy
          expect(ekohe.products.empty?).to be_truthy
        end
      end

      context 'mx-media-llc data' do
        it 'should return Crunchbase::Exception with 404 as results' do
          expect {
            parse_json('organizations', 'mx-media-llc')
          }.to raise_error(Crunchbase::Exception)
        end
      end
    end
  end
end
