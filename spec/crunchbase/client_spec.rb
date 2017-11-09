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
  end
end
