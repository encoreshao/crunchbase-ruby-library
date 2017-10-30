# frozen_string_literal: true

module ApiHelper
  def parse_json(endpoint, filename)
    JSON.parse(load_file(endpoint, filename))['data']
  end

  def load_file(endpoint, filename)
    File.read(File.join(File.dirname(__FILE__), "../data/#{endpoint}", "#{filename}.json"))
  end

  def search_results(data, kclass)
    Crunchbase::Model::Search.new({}, data, kclass)
  end
end