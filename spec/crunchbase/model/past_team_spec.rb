# frozen_string_literal: true

module Crunchbase
  module Model
    RSpec.describe PastTeam do
      let(:past_team_data) { parse_json('past_team', 'facebook') }

      context 'past_team of facebook' do
        let(:past_team) { PastTeam.organization_lists('facebook') }

        before :each do
          result = search_results(past_team_data, PastTeam)

          allow(PastTeam).to receive(:organization_lists).and_return(result)
        end

        it 'should return 4 of total count with past_team' do
          expect(past_team.results.size).to eq(100)
        end

        it 'should paging values from past_team response' do
          expect(past_team.total_items).to eq(416)
          expect(past_team.pages).to eq(5)
          expect(past_team.current_page).to eq(1)
          expect(past_team.per_page).to eq(100)
        end

        it 'should return first past team record' do
          first_item = past_team.results.first

          expect(first_item.type_name).to eq('Job')
          expect(first_item.uuid).to eq('29939253caf107957250298344c8d3e6')
          expect(first_item.title).to eq('Director of Security Incident Response')
          expect(first_item.person.first_name).to eq('Ryan')
        end

        it 'should return last past team record' do
          last_item = past_team.results.last

          expect(last_item.type_name).to eq('Job')
          expect(last_item.uuid).to eq('3e535020b46ba9487d46a724986c99e1')
          expect(last_item.title).to eq('core infrastructure systems')
          expect(last_item.person.first_name).to eq('Nikita')
        end
      end
    end
  end
end
