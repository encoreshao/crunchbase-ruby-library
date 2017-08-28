# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class AcquiredBy < Crunchbase::Model::Entity
    RESOURCE_LIST = 'acquired_by'

    attr_reader :uuid, :type_name
    attr_reader :api_path, :web_path, :price, :price_currency_code, :price_usd, :payment_type, :acquisition_type, :acquisition_status, :disposition_of_acquired, :announced_on, :announced_on_trust_code, :completed_on, :completed_on_trust_code, :created_at, :updated_at

    attr_reader :acquiree, :acquirer

    def initialize(json)
      super

      unless (relationships = json['relationships']).nil?
        instance_relationships_object(Crunchbase::Model::Organization, 'aquiree', relationships['acquiree'])
        instance_relationships_object(Crunchbase::Model::Organization, 'acquirer', relationships['acquirer'])
      end
    end

    def property_keys
      %w(api_path web_path price price_currency_code price_usd payment_type acquisition_type acquisition_status disposition_of_acquired announced_on announced_on_trust_code completed_on completed_on_trust_code created_at updated_at)
    end

    def date_keys
      %w(announced_on completed_on)
    end
  end
end
