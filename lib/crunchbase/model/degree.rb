# frozen_string_literal: true

module Crunchbase::Model
  class Degree < Entity
    RESOURCE_LIST = 'degrees'.freeze

    attr_reader :degree_type_name, :degree_subject, :started_on, :started_on_trust_code, :is_completed,
                :completed_on, :completed_on_trust_code,
                :created_at, :updated_at

    attr_reader :school

    def initialize(json)
      super

      return if (relationships = json['relationships']).nil?

      instance_relationships_object(Crunchbase::Model::School, 'school', relationships['school'])
    end

    def property_keys
      %w(
        degree_type_name degree_subject started_on started_on_trust_code is_completed
        completed_on completed_on_trust_code
        created_at updated_at
      )
    end
  end
end
