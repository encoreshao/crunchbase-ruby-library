# encoding: utf-8

module Crunchbase::Model
  class OwnedBy < Crunchbase::Model::Entity

    attr_reader :name, :path, :created_at, :updated_at

    def initialize(json)
      instance_variable_set("@type_name",  json['type'] || nil)

      property_keys.each { |v| 
        instance_variable_set("@#{v}", json[v] || nil) 
      }

      %w[created_at updated_at].each { |v| 
        instance_variable_set("@#{v}", Time.at(json[v])) 
      }
    end

    def property_keys
      %w[
        name path created_at updated_at
      ]
    end

  end
end