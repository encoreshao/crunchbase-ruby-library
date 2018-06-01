# frozen_string_literal: true

module Crunchbase
  RSpec.describe Client do
    let(:client) { Crunchbase::Client.new }
    let(:facebook_json_data) { parse_json('organizations', 'facebook') }

    context '#get facebook information' do
      let(:facebook_data1) { client.get('facebook', 'Organization') }
      let(:facebook_data2) { Model::Organization.get('facebook') }

      before :each do
        result = Model::Organization.new(facebook_json_data)

        allow(client).to receive(:get).and_return(result)
        allow(Model::Organization).to receive(:get).and_return(result)
      end

      it 'should return `facebook` as permalink' do
        expect(facebook_data2.permalink).to eq('facebook')
        expect(facebook_data1.permalink).to eq('facebook')
      end
    end

    context '#get batched data' do
      let(:response) { client.batch_search([{ type: 'Organization', uuid: 'df6628127f970b439d3e12f64f504fbb' }]) }

      it 'should return batch search data' do
        expect(response).to be_an_instance_of(Crunchbase::Model::BatchSearch)
        expect(response.results).to be_an_instance_of(Array)
        expect(response.results).to be_present
      end
    end
  end
end
