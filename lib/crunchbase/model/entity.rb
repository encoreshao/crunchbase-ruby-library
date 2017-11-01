# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class Entity
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
      relationship_lists.map { |key, kclass| set_relationships_object(kclass, key, relationships[key]) }
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

    def set_relationships_object(kclass_name, key, list)
      return unless list

      one_to_one(kclass_name, key, list) if list.is_a?(Hash)
      one_to_one(kclass_name, key, list['item']) if list['item']
      one_to_many(kclass_name, key, list) if list['items']
    end

    def one_to_one(kclass_name, key, item)
      return unless item

      instance_variable_set "@#{key}", (kclass_name.new(item) || nil)
      instance_variable_set "@#{key}_total_items", (item ? 1 : 0)
    end

    def one_to_many(kclass_name, key, list)
      return unless list['items'].respond_to?(:each)

      instance_variable_set "@#{key}", list['items'].inject([]) { |v, i| v << kclass_name.new(i) }
      instance_variable_set "@#{key}_total_items", list['paging']['total_items']
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

    class << self
      # Factory method to return an instance from a permalink
      def get(permalink)
        result = Crunchbase::API.single_entity(permalink, self::RESOURCE_NAME)

        new(result)
      end

      def list(page = nil)
        model_name = kclass_name(self::RESOURCE_LIST)

        Crunchbase::API.list({ page: page, model_name: model_name }, self::RESOURCE_LIST)
      end

      def organization_lists(permalink, options = {})
        options = options.merge(model_name: self)

        Crunchbase::API.organization_lists(permalink, self::RESOURCE_LIST, options)
      end

      def person_lists(permalink, options = {})
        options = options.merge(model_name: self)

        Crunchbase::API.person_lists(permalink, self::RESOURCE_LIST, options)
      end

      def funding_rounds_lists(permalink, options = {})
        options = options.merge(model_name: self)

        Crunchbase::API.funding_rounds_lists(permalink, self::RESOURCE_LIST.tr('_', '-'), options)
      end

      def array_from_list(list)
        return [] if list.nil?

        list['items'].map do |l|
          new l if l.is_a?(Hash)
        end.compact
      end

      def parsing_from_list(list)
        return [] if list.nil?

        list.map do |l|
          new l if l.is_a?(Hash)
        end.compact
      end

      def total_items_from_list(list)
        return 0 if list.nil?

        list['paging']['total_items']
      end

      def kclass_name(resource_list)
        API::SUPPORTED_ENTITIES[resource_list] || nil
      end
    end
  end
end
