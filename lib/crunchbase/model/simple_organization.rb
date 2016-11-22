# encoding: utf-8

module Crunchbase::Model
  class SimpleOrganization < Crunchbase::Model::Entity

    attr_reader :type, :name, :path, :created_at, :updated_at

    def initialize(json)
      property_keys.each { |v|
        instance_variable_set("@#{v}", json[v] || nil)
      }

      %w[created_at updated_at].each { |v|
        instance_variable_set("@#{v}", Time.at(json[v])) unless json[v].nil?
      }
    end

    def property_keys
      %w[
        type name path created_at updated_at
      ]
    end

  end
end
