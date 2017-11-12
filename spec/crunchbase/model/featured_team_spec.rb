# frozen_string_literal: true

module Crunchbase
  module Model
    RSpec.describe FeaturedTeam do
      let(:featured_team_data) { parse_json('featured_team', 'facebook') }

      context 'featured_team of facebook' do
        let(:featured_team) { FeaturedTeam.organization_lists('facebook') }

        before :each do
          result = search_results(featured_team_data, FeaturedTeam)

          allow(FeaturedTeam).to receive(:organization_lists).and_return(result)
        end

        it 'should return 4 of total count with featured_team' do
          expect(featured_team.results.size).to eq(6)
        end

        it 'should paging values from featured_team response' do
          expect(featured_team.total_items).to eq(6)
          expect(featured_team.pages).to eq(1)
          expect(featured_team.current_page).to eq(1)
          expect(featured_team.per_page).to eq(100)
        end

        it 'should return first past team record' do
          first_item = featured_team.results.first

          expect(first_item.type_name).to eq('Job')
          expect(first_item.uuid).to eq('befc22dec7892096e4d6919935cf4204')
          expect(first_item.title).to eq('Founder & CEO')
          expect(first_item.person.first_name).to eq('Mark')
          expect(first_item.person.last_name).to eq('Zuckerberg')
        end
      end
    end
  end
end
