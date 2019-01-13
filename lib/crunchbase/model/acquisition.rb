# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class Acquisition < Entity
    RESOURCE_LIST = 'acquisitions'.freeze
    RESOURCE_NAME = 'acquisitions'.freeze

    attr_reader :api_path, :web_path, :price, :price_currency_code, :price_usd,
                :payment_type, :acquisition_type, :acquisition_status, :disposition_of_acquired,
                :announced_on, :announced_on_trust_code, :completed_on, :completed_on_trust_code,
                :acquirer, :acquiree, :news,
                :acquirer_total_items, :acquiree_total_items, :news_items,
                :created_at, :updated_at

    def initialize(json)
      super

      relationships = json['relationships']
      return if relationships.nil?

      if relationships['acquiree']['item'].nil?
        instance_relationships_object(Organization, 'acquiree', relationships['acquiree'])
      else
        set_relationships_object(Acquiree, 'acquiree', relationships['acquiree'])
        set_relationships_object(Acquirer, 'acquirer', relationships['acquirer'])
        set_relationships_object(New, 'news', relationships['news'])
      end
    end

    def property_keys
      %w(
        api_path web_path price price_currency_code price_usd
        payment_type acquisition_type acquisition_status disposition_of_acquired
        announced_on announced_on_trust_code completed_on completed_on_trust_code
        created_at updated_at
      )
    end

    def date_keys
      %w(announced_on completed_on)
    end
  end
end
