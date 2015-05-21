# encoding: utf-8

module Crunchbase::Model
  class SearchResult < Relationship

    def initialize(json)
      super(json)
    end

  end
end