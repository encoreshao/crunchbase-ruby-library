# encoding: utf-8

module Crunchbase::Model
  class PrimaryLocation < Crunchbase::Model::Location

    attr_reader :parent_locations

    def initialize(json)
      super

      unless (relationships = json['relationships']).nil?
        set_relationships_object(Crunchbase::Model::ParentLocation, 'parent_locations', relationships['parent_locations'])
      end
    end

  end
end