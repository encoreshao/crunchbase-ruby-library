# encoding: utf-8

module Crunchbase::Model
  class AcquiredBy < Crunchbase::Model::Entity

    RESOURCE_LIST = 'acquired_by'

    attr_reader :announced_on, :name, :path, :created_at, :updated_at

    def initialize(json)
      property_keys.each { |v|
        instance_variable_set("@#{v}", json[v] || nil)
      }

      %w[created_at updated_at].each { |v|
        if not json[v].nil?
          instance_variable_set("@#{v}", Time.at(json[v]))
        end
      }
    end

    def property_keys
      %w[ announced_on name path created_at updated_at ]
    end

    def date_keys
      %w[ announced_on ]
    end

  end
end
