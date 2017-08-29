# frozen_string_literal: true
require 'singleton'
require 'time'

require 'json'
require 'crunchbase/version'
require 'crunchbase/model'
require 'crunchbase/api'
require 'crunchbase/exception'

module Crunchbase
  API_VERSION     = '3.1'
  API_BASE_URL    = 'https://api.crunchbase.com'
  WEB_SITE_URL    = 'https://www.crunchbase.com'
  IMAGE_URL       = 'https://res.cloudinary.com/crunchbase-production/'

  class << self
  end
end
