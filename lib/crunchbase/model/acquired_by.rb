# frozen_string_literal: true

module Crunchbase
  module Model
    class AcquiredBy < Entity
      RESOURCE_LIST = 'acquired_by'.freeze

      attr_reader :uuid, :type_name, :api_path, :web_path, :price, :price_currency_code, :price_usd,
                  :payment_type, :acquisition_type, :acquisition_status, :disposition_of_acquired,
                  :announced_on, :announced_on_trust_code, :completed_on, :completed_on_trust_code,
                  :acquiree, :acquirer, :created_at, :updated_at

      def initialize(json)
        super(json)
      end

      def relationship_lists
        {
          'aquiree' => Organization,
          'acquirer' => Organization
        }
      end

      def property_keys
        %w(api_path web_path price price_currency_code price_usd payment_type acquisition_type acquisition_status disposition_of_acquired announced_on announced_on_trust_code completed_on completed_on_trust_code created_at updated_at)
      end

      def date_keys
        %w(announced_on completed_on)
      end
    end
  end
end
