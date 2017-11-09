# encoding: utf-8
# frozen_string_literal: true

module Crunchbase
  module Model
    class Entity
      extend Request::Client

      attr_reader :type_name, :uuid

      def initialize(json)
        instance_variable_set('@type_name', json['type'] || nil)
        instance_variable_set('@uuid',  json['uuid'] || nil)

        properties = json['properties'] || {}
        property_keys.each { |v| instance_variable_set("@#{v}", properties[v]) }
        date_keys.each { |v| instance_variable_set("@#{v}", properties[v].nil? ? nil : Date.parse(properties[v])) }

        instance_timestamps(properties)

        relationships = json['relationships']
        return if relationships.nil? || relationship_lists.empty?

        setup_relationships_data!(relationships)
      end

      def setup_relationships_data!(relationships)
        relationship_lists.each do |key, kclass|
          set_relationships_object(kclass, key, relationships[key])
        end
      end

      def instance_timestamps(properties)
        %w(created_at updated_at).each do |v|
          instance_variable_set("@#{v}", convert_date!(properties[v]))
        end
      end

      def convert_date!(date)
        return Time.parse(date) if date.is_a?(String)

        Time.at(date)
      rescue
        nil
      end

      def fetch
        fetch_object = get_fetch_object
        return [] if fetch_object.empty?

        fetch_object[0].new Crunchbase::API.fetch(permalink, fetch_object[1])
      end

      # TODO: need to be implement
      def property_keys
        []
      end

      def date_keys
        []
      end

      def relationship_lists
        { }
      end

      def set_relationships_object(kclass, key, list)
        return if list.nil? || list.empty?
        return unless list

        if list.is_a?(Array)
          set_variables(kclass, key, list)
        elsif list.is_a?(Hash)
          parse_hash_items(kclass, key, list)
        end
      end

      def parse_hash_items(kclass, key, list)
        one_to_one(kclass, key, list)
        one_to_one(kclass, key, list['item']) if list['item']
        one_to_many(kclass, key, list) if list['items']
      end

      def one_to_one(kclass, key, item)
        return unless item

        result = special_relationship(kclass, item)
        instance_variable_set "@#{key}", result[:item]
        instance_variable_set "@#{key}_total_items", result[:count]
      end

      # {
      #   "cardinality"=>"OneToOne",
      #   "paging"=>{"total_items"=>0,
      #   "first_page_url"=>"https://api.crunchbase.com/v3.1/organizations/facebook/acquired_by",
      #   "sort_order"=>"not_ordered"
      # }
      def special_relationship(kclass, item)
        return { item: nil, count: 0 } if verify_item?(item)

        { item: (kclass.new(item) || nil), count: (item ? 1 : 0) }
      end

      def verify_item?(item)
        item['cardinality'] == 'OneToOne' && (item['paging']['total_items']).zero?
      end

      def one_to_many(kclass, key, list)
        return unless list['items'].respond_to?(:each)

        set_variables(kclass, key, list['items'])
        instance_variable_set "@#{key}_total_items", list['paging']['total_items']
      end

      def set_variables(kclass, key, items)
        instance_variable_set "@#{key}", items.inject([]) { |v, i| v << kclass.new(i) }
      end

      def instance_relationships_object(kclass, key, item)
        return unless item

        instance_variable_set "@#{key}", (kclass.new(item) || nil)
      end

      def instance_multi_relationship_objects(kclass, key, items)
        multi_items = []

        items.map { |item| multi_items << kclass.new(item || nil) }
        instance_variable_set "@#{key}", multi_items
        instance_variable_set "@#{key}_total_items", multi_items.size
      end
    end
  end
end
