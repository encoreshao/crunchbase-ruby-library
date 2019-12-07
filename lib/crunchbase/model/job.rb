# frozen_string_literal: true

module Crunchbase::Model
  class Job < Entity
    RESOURCE_LIST = 'jobs'

    # Attributes
    attr_reader :title, :job_type, :started_on, :started_on_trust_code, :ended_on, :ended_on_trust_code,
                :created_at, :updated_at

    # Relationships
    attr_reader :person, :organization

    def initialize(json)
      super
    end

    def relationship_lists
      {
        'person' => Person,
        'organization' => Organization
      }
    end

    def property_keys
      %w[
        title job_type started_on started_on_trust_code ended_on ended_on_trust_code created_at updated_at
      ]
    end

    def date_keys
      %w[started_on ended_on]
    end
  end
end
