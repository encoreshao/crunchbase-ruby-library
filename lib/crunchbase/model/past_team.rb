# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class PastTeam < Job
    RESOURCE_LIST = 'past_team'

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
