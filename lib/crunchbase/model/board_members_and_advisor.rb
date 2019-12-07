# frozen_string_literal: true

module Crunchbase::Model
  class BoardMembersAndAdvisor < Job
    RESOURCE_LIST = 'board_members_and_advisors'.freeze

    attr_reader :person

    def initialize(json)
      super
    end

    def relationship_lists
      {
        'person' => Person
      }
    end

    # Factory method to return an instance from a permalink
    def self.get(_permalink)
      nil
    end
  end
end
