# frozen_string_literal: true

module ApiHelper
  def parse_json(endpoint, filename)
    response = JSON.parse(load_file(endpoint, filename))
    response = response[0] if response.is_a?(Array)

    raise Crunchbase::Exception, message: response['message'], status: response['status'] unless response['message'].nil?

    response['data']
  end

  def load_file(endpoint, filename)
    json_file = File.join(File.dirname(__FILE__), "../data/#{endpoint}", "#{filename}.json")

    File.read(json_file)
  end

  def search_results(data, kclass)
    Crunchbase::Model::Search.new({}, data, kclass)
  end
end
