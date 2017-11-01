# frozen_string_literal: true

module Crunchbase
  module Model
    RSpec.describe CurrentTeam do
      let(:current_team_data) { parse_json('current_team', 'facebook') }

      context 'current_team of facebook' do
        let(:current_team) { CurrentTeam.organization_lists('facebook') }

        before :each do
          result = search_results(current_team_data, CurrentTeam)

          allow(CurrentTeam).to receive(:organization_lists).and_return(result)
        end

        it 'should return 4 of total count with current_team' do
          expect(current_team.results.size).to eq(100)
        end

        it 'should paging values from current_team response' do
          expect(current_team.total_items).to eq(491)
          expect(current_team.pages).to eq(5)
          expect(current_team.current_page).to eq(1)
          expect(current_team.per_page).to eq(100)
        end

        it 'should return first past team record' do
          first_item = current_team.results.first

          expect(first_item.type_name).to eq('Job')
          expect(first_item.uuid).to eq('24ba8e19092e4b6e9a62cf009fd367a0')
          expect(first_item.title).to eq('Product Manager')
          expect(first_item.person.first_name).to eq('Chetan')
          expect(first_item.person.last_name).to eq('Gupta')
        end

        it 'should return last past team record' do
          last_item = current_team.results.last

          expect(last_item.type_name).to eq('Job')
          expect(last_item.uuid).to eq('0636f8716c9ca7ec00c6fc8bfab030f0')
          expect(last_item.title).to eq('Production Engineer')
          expect(last_item.person.first_name).to eq('Richard')
          expect(last_item.person.last_name).to eq('Wareing')
        end
      end
    end
  end
end
