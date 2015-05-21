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
        instance_variable_set("@#{v}", Time.at(json['properties'][v])) 
      }
    end
    
    # Factory method to return an instance from a permalink  
    def self.get(permalink)
      return self.new( Crunchbase::API.single_entity(permalink, self::RESOURCE_NAME) )
    end

    # Finds an entity by its name. Uses two HTTP requests; one to find the
    # permalink, and another to request the actual entity.
    def self.search(options)
      return [] unless self == Crunchbase::Model::Organization

      return Search.new options, API.search( options, self::RESOURCE_LIST ), SearchResult
    end
    
    def self.lists_for_permalink(permalink, options={})
      return API.lists_for_permalink(permalink, self::RESOURCE_LIST, options)
    end

    def self.lists_for_person_permalink(permalink, options={})
      return API.lists_for_person_permalink(permalink, self::RESOURCE_LIST, options)
    end

    def self.category_lists_by_permalink(permalink, classify_name, options={})
      return API.lists_for_category(classify_name, permalink, self::RESOURCE_LIST, options)
    end

    def fetch
      fetch_object = get_fetch_object
      return [] if fetch_object.empty?

      return fetch_object[0].new API.fetch(self.permalink, fetch_object[1])
    end

    def self.list(page=nil)
      options = { page: page, model_name: self }

      return API.list( options, self::RESOURCE_LIST )
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
      return unless list and list['items'].respond_to?(:each)

      items = []
      list['items'].each { |v| items << object_name.array_from_list(list) }
      instance_variable_set "@#{key}", items

      total_items = list['paging']['total_items'] 
      total_items = list['items'].size if key == 'headquarters'
      instance_variable_set "@#{key}_total_items", total_items
    end
  end
end
