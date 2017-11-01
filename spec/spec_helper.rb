# frozen_string_literal: true
$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

require 'rspec'
require 'rspec/its'
require 'crunchbase'
require 'time'
require 'yaml'
require 'coveralls'
Coveralls.wear!

yaml = YAML.load_file(File.join(File.dirname(__FILE__), 'crunchbase.yml'))

Crunchbase::API.key   = yaml['user_key']
Crunchbase::API.debug = yaml['debug']

Dir[File.dirname(__FILE__) + '/crunchbase/support/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include ApiHelper
end
