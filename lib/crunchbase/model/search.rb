# frozen_string_literal: true

module Crunchbase
  module Model
    class Search < Entity
      include Enumerable

      attr_reader :total_items, :per_page, :pages, :current_page, :prev_page_url, :next_page_url
      attr_reader :sort_order, :results

      alias length total_items
      alias size   total_items
      alias items  results

      def initialize(query, json, kclass)
        @query            = query
        @results          = []
        @total_items      = 0
        @pages            = 0

        populate_results(json, kclass) if json['error'].nil?
      end

      def populate_results(json, kclass)
        @results = []
        @results = json['items'].map { |r| kclass.new(r) } unless json['items'].nil?

        @total_items      = json['paging']['total_items']
        @per_page         = json['paging']['items_per_page']
        @pages            = json['paging']['number_of_pages']
        @current_page     = json['paging']['current_page']
        @prev_page_url    = json['paging']['prev_page_url']
        @next_page_url    = json['paging']['next_page_url']
        @sort_order       = json['paging']['sort_order']
      end

      # Finds an entity by its name. Uses two HTTP requests; one to find the
      # permalink, and another to request the actual entity.
      def self.search(options, resource_list)
        model_name = kclass_name(resource_list)

        raise 'Unknown type error!' if model_name.nil?

        Search.new options, API.search(options, resource_list), model_name
      end

      # Factory method to return an instance from a permalink
      def self.get(_permalink)
        nil
      end
    end
  end
end
