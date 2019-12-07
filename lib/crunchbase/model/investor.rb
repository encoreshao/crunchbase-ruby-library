# frozen_string_literal: true

module Crunchbase::Model
  class Investor < Entity
    RESOURCE_LIST = 'investors'.freeze

    attr_reader :object

    def initialize(json)
      instance_relationships_object(Person, 'object', json) if json['type'] == 'Person'
      instance_relationships_object(Organization, 'object', json) if json['type'] == 'Organization'
    end

    def person?
      (object.type_name == 'Person')
    end

    def organization?
      (object.type_name == 'Organization')
    end
  end
end
