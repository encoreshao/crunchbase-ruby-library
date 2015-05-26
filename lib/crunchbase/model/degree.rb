# encoding: utf-8

module Crunchbase::Model
  class Degree < Crunchbase::Model::Entity

    RESOURCE_LIST = 'degrees'

    attr_reader :degree_type_name, :degree_subject, :started_on, :started_on_trust_code, :is_completed, 
                :completed_on, :completed_on_trust_code, 
                :created_at, :updated_at

    attr_reader :school

    def initialize(json)
      super

      unless (relationships = json['relationships']).nil?
        set_relationships_object(Crunchbase::Model::School, 'school', relationships['school'])
      end
    end

    def property_keys
      %w[
        degree_type_name degree_subject started_on started_on_trust_code is_completed 
        completed_on completed_on_trust_code 
        created_at updated_at
      ]
    end

    def set_relationships_object(object_name, key, item)
      return unless item

      instance_variable_set "@#{key}", ( object_name.new(item) || nil )
    end

  end
end