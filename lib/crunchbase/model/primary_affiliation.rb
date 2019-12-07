# frozen_string_literal: true

module Crunchbase::Model
  class PrimaryAffiliation < Job
    attr_reader :organization

    def initialize(json)
      super

      return if (relationships = json['relationships']).nil?

      set_relationships_object(Organization, 'organization', relationships['organization'])
    end

    def set_relationships_object(kclass_name, key, item)
      return unless item

      instance_variable_set "@#{key}", (kclass_name.new(item) || nil)
    end
  end
end
