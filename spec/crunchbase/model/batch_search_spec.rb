# frozen_string_literal: true

module Crunchbase::Model
	RSpec.describe BatchSearch do

		context 'perform invalid batch_search' do
			it 'should raise ConfigurationException for non-array argument' do
				expect { BatchSearch.batch_search({}) }.to raise_error Crunchbase::ConfigurationException
			end

			it 'should raise InvalidRequestException for too many requests' do
				expect { BatchSearch.batch_search(Array.new(11)) }.to raise_error Crunchbase::InvalidRequestException
			end

			it 'should raise MissingParamsException for invalid array item (without type and uuid fields)' do
				invalid_array_arguments = [
					[{}],
					[{ type: 'Organization' }],
					[{ type: 'Organization', uuid: 'unique_id' }, {}],
					[{ type: 'Organization', uuid: 'unique_id' }, { uuid: 'unique_id' }]
				]

				invalid_array_arguments.each do |invalid_argument|
					expect { BatchSearch.batch_search(invalid_argument) }.to raise_error Crunchbase::MissingParamsException
				end
			end

			it 'should return an empty array for empty array argument' do
				results = BatchSearch.batch_search([])
				expect(results).to be_empty
			end

			it 'should return an instance of Error for invalid uuid' do
				invalid_request = [{ type: 'Organization', uuid: 'invalid_id' }]
				results = BatchSearch.batch_search(invalid_request)

				expect(results.results.first).to be_an_instance_of(Crunchbase::Model::Error)
			end
		end

		context 'perform valid batch_search' do
			let(:requests) {
				[
					{ type: 'Organization', uuid: 'df6628127f970b439d3e12f64f504fbb' },
					{ type: 'Organization', uuid: '0ea85f0296e15c42feebb786ecab2939' },
					{ type: 'Person', uuid: 'a01b8d46d31133337c34aa3ae9c03f22' }
				]
			}
			let(:batch_search) { BatchSearch.batch_search(requests) }

			it 'should return new instance of BatchSearch' do
				expect(batch_search).to be_an_instance_of(BatchSearch)
			end

			it 'should return an array of results' do
				results = batch_search.results
				expect(results).to be_an_instance_of(Array)
				expect(results).not_to be_empty
			end

			it 'should return an array of valid model objects' do
				results = batch_search.results
				expect(results[0]).to be_a(Crunchbase::Model::Organization)
				expect(results[1]).to be_a(Crunchbase::Model::Organization)
				expect(results[2]).to be_a(Crunchbase::Model::Person)
			end
		end
	end
end