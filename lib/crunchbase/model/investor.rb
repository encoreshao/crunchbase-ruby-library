# encoding: utf-8

module Crunchbase::Model
  class Investor < Crunchbase::Model::Entity
    
    RESOURCE_LIST = 'investors'

    attr_reader :object

    def initialize(json)
      set_relationship_object('object', Crunchbase::Model::Person, json) if json['type'] == 'Person'
      set_relationship_object('object', Crunchbase::Model::Organization, json) if json['type'] == 'Organization'
    end

    def set_relationship_object(key, object_name, json)
      instance_variable_set "@#{key}", ( object_name.new(json) || nil )
    end

  end
end
