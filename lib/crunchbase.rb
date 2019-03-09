# frozen_string_literal: true

require 'singleton'
require 'time'

require 'json'
require 'crunchbase/version'
require 'crunchbase/model'
require 'crunchbase/request'
require 'crunchbase/client'
require 'crunchbase/api'
require 'crunchbase/exception'

module Crunchbase
  API_VERSION     = 'v3.1'.freeze
  API_BASE_URL    = 'https://api.crunchbase.com'.freeze
  WEB_SITE_URL    = 'https://www.crunchbase.com'.freeze
  IMAGE_URL       = 'https://res.cloudinary.com/crunchbase-production/'.freeze

  class << self
  end
end
