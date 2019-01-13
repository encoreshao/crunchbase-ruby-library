# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class Job < Entity
    RESOURCE_LIST = 'jobs'.freeze

    attr_reader :title, :started_on, :started_on_trust_code, :ended_on, :ended_on_trust_code,
                :created_at, :updated_at

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
      %w(
        title started_on started_on_trust_code ended_on ended_on_trust_code created_at updated_at
      )
    end

    def date_keys
      %w(started_on ended_on)
    end
  end
end
