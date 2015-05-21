# encoding: utf-8

module Crunchbase::Model
  class Investor < Crunchbase::Model::Entity
    
    RESOURCE_LIST = 'investors'

    attr_reader :name, :type_name, :path, :permalink, :first_name, :last_name, :type

    def initialize(hash)

    end
    
  end
end
