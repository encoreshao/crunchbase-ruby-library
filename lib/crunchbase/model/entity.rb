# encoding: utf-8

module Crunchbase::Model
  class Entity

    attr_reader :type_name, :uuid

    def initialize(json)
      instance_variable_set("@type_name",  json['type'] || nil)
      instance_variable_set("@uuid",  json['uuid'] || nil)

      property_keys.each { |v|
        instance_variable_set("@#{v}", json['properties'][v] || nil)
      }

      date_keys.each { |v|
        instance_variable_set("@#{v}", json['properties'][v].nil? ? nil : Date.parse(json['properties'][v]))
      }

      %w[created_at updated_at].each { |v|
        if json['properties'][v].kind_of?(String)
          instance_variable_set( "@#{v}", begin Time.parse(json['properties'][v]) rescue nil end )
        else
          instance_variable_set( "@#{v}", begin Time.at(json['properties'][v]) rescue nil end )
        end
      }
    end

    # Factory method to return an instance from a permalink
    def self.get(permalink)
      result = Crunchbase::API.single_entity(permalink, self::RESOURCE_NAME)

      return self.new( result )
    end

    def self.list(page=nil)
      model_name = get_model_name(self::RESOURCE_LIST)

      return Crunchbase::API.list( { page: page, model_name: model_name }, self::RESOURCE_LIST )
    end

    def self.organization_lists(permalink, options={})
      options = options.merge({ model_name: self })

      return Crunchbase::API.organization_lists(permalink, self::RESOURCE_LIST, options)
    end

    def self.person_lists(permalink, options={})
      options = options.merge({ model_name: self })

      return Crunchbase::API.person_lists(permalink, self::RESOURCE_LIST, options)
    end

    def self.funding_rounds_lists(permalink, options={})
      options = options.merge({ model_name: self })

      return Crunchbase::API.funding_rounds_lists(permalink, self::RESOURCE_LIST.gsub('_', '-'), options)
    end

    def fetch
      fetch_object = get_fetch_object
      return [] if fetch_object.empty?

      return fetch_object[0].new API.fetch(self.permalink, fetch_object[1])
    end

    def self.array_from_list(list)
      return [] if list.nil?

      list['items'].map do |l|
        self.new l if l.kind_of?(Hash)
      end.compact
    end

    def self.parsing_from_list(list)
      return [] if list.nil?

      list.map do |l|
        self.new l if l.kind_of?(Hash)
      end.compact
    end

    def self.total_items_from_list(list)
      return 0 if list.nil?

      list['paging']['total_items']
    end

    private

    def property_keys
      []
    end

    def date_keys
      []
    end

    def set_relationships_object(object_name, key, list)
      return unless list

      one_to_one(object_name, key, list['item']) if list['item']
      one_to_many(object_name, key, list) if list['items']
    end

    def one_to_one(object_name, key, item)
      return unless item

      instance_variable_set "@#{key}", ( object_name.new( item ) || nil )
      instance_variable_set "@#{key}_total_items", (item ? 1 : 0)
    end

    def one_to_many(object_name, key, list)
      return unless list['items'].respond_to?(:each)

      instance_variable_set "@#{key}", list['items'].inject([]) { |v, i| v << object_name.new(i) }
      instance_variable_set "@#{key}_total_items", list['paging']['total_items']
    end

    def instance_relationships_object(object_name, key, item)
      return unless item

      instance_variable_set "@#{key}", ( object_name.new(item) || nil )
    end

    def self.get_model_name(resource_list)
      return nil unless ['organizations', 'people', 'products', 'ipos'].include?(resource_list)

      case resource_list
      when 'organizations'
        OrganizationSummary
      when 'people'
        PersonSummary
      when 'products'
        ProductSummary
      when 'ipos'
        Ipo
      else
        nil
      end
    end

  end
end
