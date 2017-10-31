# frozen_string_literal: true

module Crunchbase
  module Model
    RSpec.describe Person do
      let(:mark_zuckerberg_json_data) { parse_json('people', 'mark-zuckerberg') }

      context 'Person - with mark zuckerberg' do
        let(:mark_zuckerberg) { Person.get('mark-zuckerberg') }

        before :each do
          result = Person.new(mark_zuckerberg_json_data)

          allow(Person).to receive(:get).and_return(result)
        end

        it 'should return personal information with mark zuckerberg' do
          expect(mark_zuckerberg.type_name).to eq('Person')
          expect(mark_zuckerberg.uuid).to eq('a01b8d46d31133337c34aa3ae9c03f22')
          expect(mark_zuckerberg.first_name).to eq('Mark')
          expect(mark_zuckerberg.last_name).to eq('Zuckerberg')
          expect(mark_zuckerberg.gender).to eq('Male')
          expect(mark_zuckerberg.born_on).to eq(Date.parse('1984-05-14'))
          expect(mark_zuckerberg.role_investor).to eq(true)
        end
      end
    end
  end
end
