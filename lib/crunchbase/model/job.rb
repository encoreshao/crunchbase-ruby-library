# encoding: utf-8

module Crunchbase::Model
  class Job < Crunchbase::Model::Entity
    
    RESOURCE_LIST = 'jobs'

    attr_reader :title, :started_on, :started_on_trust_code, :ended_on, :ended_on_trust_code, 
                :created_at, :updated_at

    attr_reader :person, :organization

    def initialize(json)
      super

      unless (relationships = json['relationships']).nil?
        instance_relationships_object(Crunchbase::Model::Person, 'person', relationships['person'])
        instance_relationships_object(Crunchbase::Model::Organization, 'organization', relationships['organization'])
      end
    end
    
    def property_keys
      %w[
        title started_on started_on_trust_code ended_on ended_on_trust_code created_at updated_at
      ]
    end

    def date_keys
      %w[ started_on ended_on ]
    end

  end
end