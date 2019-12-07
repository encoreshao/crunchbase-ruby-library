# frozen_string_literal: true

module Crunchbase::Model
  class PrimaryLocation < Location
    attr_reader :parent_locations

    def initialize(json)
      super
    end

    def relationship_lists
      {
        'parent_locations' => ParentLocation
      }
    end
  end
end
