require 'singleton'

require "crunchbase/version"
require "crunchbase/configuration"
require 'crunchbase/api'
require 'crunchbase/model'
require "crunchbase/exception"

module Crunchbase
  class << self
    # autoload :API,        "crunchbase/api"
    # autoload :Model,      "crunchbase/model"
  end
end
