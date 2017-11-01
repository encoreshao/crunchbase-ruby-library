# frozen_string_literal: true

module Crunchbase
  module Model
    RSpec.describe BoardMembersAndAdvisor do
      let(:board_members_and_advisors_data) { parse_json('board_members_and_advisors', 'facebook') }

      context 'board_members_and_advisors of facebook' do
        let(:board_members_and_advisors) { BoardMembersAndAdvisor.organization_lists('facebook') }

        before :each do
          result = search_results(board_members_and_advisors_data, PastTeam)

          allow(BoardMembersAndAdvisor).to receive(:organization_lists).and_return(result)
        end

        it 'should return 4 of total count with board_members_and_advisors' do
          expect(board_members_and_advisors.results.size).to eq(10)
        end

        it 'should paging values from board_members_and_advisors response' do
          expect(board_members_and_advisors.total_items).to eq(10)
          expect(board_members_and_advisors.pages).to eq(1)
          expect(board_members_and_advisors.current_page).to eq(1)
          expect(board_members_and_advisors.per_page).to eq(100)
        end

        it 'should return first board members and advisor record' do
          first_item = board_members_and_advisors.results.first

          expect(first_item.type_name).to eq('Job')
          expect(first_item.uuid).to eq('151a676d610d420a887640cf7b922945')
          expect(first_item.title).to eq('Member of the Board of Directors')
          expect(first_item.person.first_name).to eq('Jan')
        end

        it 'should return last board members and advisor record' do
          last_item = board_members_and_advisors.results.last

          expect(last_item.type_name).to eq('Job')
          expect(last_item.uuid).to eq('cd41d147b61114099ca309ced2cae6de')
          expect(last_item.title).to eq('Board Observer')
          expect(last_item.person.first_name).to eq('Paul')
        end
      end
    end
  end
end
