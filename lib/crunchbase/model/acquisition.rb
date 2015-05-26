# encoding: utf-8

module Crunchbase::Model
  class Acquisition < Crunchbase::Model::Entity
    
    RESOURCE_LIST = 'acquisitions'

    attr_reader :api_path, :web_path, :price, :price_currency_code, :price_usd, 
                :payment_type, :acquisition_type, :acquisition_status, :disposition_of_acquired, 
                :announced_on, :announced_on_trust_code, :completed_on, :completed_on_trust_code, 
                :created_at, :updated_at


    attr_reader :acquirer, :acquiree

    attr_reader :acquirer_total_items, :acquiree_total_items

    def initialize(json)
      super

      unless (relationships = json['relationships']).nil?
        instance_relationships_object(Crunchbase::Model::Organization, 'acquiree', relationships['acquiree'])
      end
    end

    def property_keys
      %w[
        api_path web_path price price_currency_code price_usd 
        payment_type acquisition_type acquisition_status disposition_of_acquired 
        announced_on announced_on_trust_code completed_on completed_on_trust_code 
        created_at updated_at
      ]
    end

  end
end