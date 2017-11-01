# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class Investment < Entity
    RESOURCE_LIST = 'investments'

    attr_reader :money_invested, :money_invested_currency_code, :money_invested_usd, :is_lead_investor,
                :announced_on, :announced_on_trust_code, :created_at, :updated_at

    attr_reader :investors, :partners

    def initialize(json)
      super

      relationships = json['relationships']
      return if relationships.nil?

      instance_relationships_object(Organization, 'investors', relationships['investors'])
      instance_multi_relationship_objects(Person, 'partners', relationships['partners'])
    end

    def property_keys
      %w(
        money_invested money_invested_currency_code money_invested_usd created_at updated_at
        is_lead_investor
      )
    end

    def date_keys
      %w(announced_on)
    end

    # def relationship_lists
    #   {
    #     'investors' => Organization,
    #     'partners' => Person
    #   }
    # end
  end
end
