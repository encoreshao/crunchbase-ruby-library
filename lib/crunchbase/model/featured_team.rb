# frozen_string_literal: true

module Crunchbase::Model
  class FeaturedTeam < Job
    RESOURCE_LIST = 'featured_team'

    attr_reader :person

    def initialize(json)
      super
    end

    def relationship_lists
      {
        'person' => Person
      }
    end
  end
end
