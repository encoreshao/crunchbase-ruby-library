# frozen_string_literal: true

module ApiHelper
  def parse_json(endpoint, filename)
    response_data = JSON.parse(load_file(endpoint, filename))
    response_data = response_data[0] if response_data.is_a?(Array)
    raise Crunchbase::Exception, message: response_data['message'], status: response_data['status'] unless response_data['message'].nil?

    response_data['data']
  end

  def load_file(endpoint, filename)
    File.read(File.join(File.dirname(__FILE__), "../data/#{endpoint}", "#{filename}.json"))
  end

  def search_results(data, kclass)
    Crunchbase::Model::Search.new({}, data, kclass)
  end
end
