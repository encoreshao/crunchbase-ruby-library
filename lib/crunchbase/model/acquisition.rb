# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class Acquisition < Crunchbase::Model::Entity
    RESOURCE_LIST = 'acquisitions'
    RESOURCE_NAME = 'acquisitions'

    attr_reader :api_path, :web_path, :price, :price_currency_code, :price_usd,
                :payment_type, :acquisition_type, :acquisition_status, :disposition_of_acquired,
                :announced_on, :announced_on_trust_code, :completed_on, :completed_on_trust_code,
                :created_at, :updated_at

    attr_reader :acquirer, :acquiree, :news

    attr_reader :acquirer_total_items, :acquiree_total_items, :news_items

    def initialize(json)
      super

      unless (relationships = json['relationships']).nil?
        if relationships['acquiree']['item'].nil?
          instance_relationships_object(Crunchbase::Model::Organization, 'acquiree', relationships['acquiree'])
        else
          set_relationships_object(Crunchbase::Model::Acquiree, 'acquiree', relationships['acquiree'])
          set_relationships_object(Crunchbase::Model::Acquirer, 'acquirer', relationships['acquirer'])
          set_relationships_object(Crunchbase::Model::New, 'news', relationships['news'])
        end
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
