# encoding: utf-8

module Crunchbase::Model
  class Membership < Crunchbase::Model::Organization

    RESOURCE_LIST = 'memberships'

    attr_reader :object

    def initialize(json)
      set_relationship_object('object', Crunchbase::Model::Person, json) if json['type'] == 'Person'
      set_relationship_object('object', Crunchbase::Model::Organization, json) if json['type'] == 'Organization'
    end

    def set_relationship_object(key, object_name, json)
      instance_variable_set "@#{key}", ( object_name.new(json) || nil )
    end

    def person?
      (object.type_name == "Person")
    end

    def organization?
      (object.type_name == "Organization")
    end

  end
end