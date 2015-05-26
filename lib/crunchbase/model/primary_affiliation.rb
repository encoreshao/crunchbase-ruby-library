# encoding: utf-8

module Crunchbase::Model
  class PrimaryAffiliation < Crunchbase::Model::Job

    attr_reader :organization

    def initialize(json)
      super

      unless (relationships = json['relationships']).nil?
        set_relationships_object(Crunchbase::Model::Organization, 'organization', relationships['organization'])
      end
    end

    def set_relationships_object(object_name, key, item)
      return unless item

      instance_variable_set "@#{key}", ( object_name.new(item) || nil )
    end
  end
end