# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class FundingRound < Entity
    RESOURCE_LIST = 'funding_rounds'.freeze
    RESOURCE_NAME = 'funding-rounds'.freeze

    attr_reader :permalink, :api_path, :web_path, :funding_type, :series, :series_qualifier,
                :announced_on, :announced_on_trust_code, :closed_on, :closed_on_trust_code,
                :money_raised, :money_raised_currency_code, :money_raised_usd,
                :target_money_raised, :target_money_raised_currency_code, :target_money_raised_usd,
                :created_at, :updated_at

    attr_reader :investments, :funded_organization, :images, :videos, :news, :investors

    attr_reader :investments_total_items, :funded_organization_total_items, :images_total_items,
                :videos_total_items, :news_total_items, :investors_total_items

    def initialize(json)
      super(json)

      relationships = json['relationships']
      return if relationships.nil?
      relationship_with_funded(relationships['funded_organization'])
    end

    def relationship_with_funded(funded_organization)
      return if funded_organization.nil?

      if funded_organization['item'].nil?
        # Get organization's  (investments - funding - organization)
        instance_relationships_object(Organization, 'funded_organization', funded_organization)
      else
        # Get funding-rounds (funded_organization - item)

        set_relationships_object(Organization, 'funded_organization', funded_organization)
      end
    end

    def relationship_lists
      {
        'investments' => Investment,
        'images' => Image,
        'videos' => Video,
        'news' => New,
        'investors' => Investor
      }
    end

    def property_keys
      %w(
        permalink api_path web_path funding_type series series_qualifier
        announced_on announced_on_trust_code closed_on closed_on_trust_code
        money_raised money_raised_currency_code money_raised_usd
        target_money_raised target_money_raised_currency_code target_money_raised_usd
        created_at updated_at
      )
    end

    def date_keys
      %w(announced_on closed_on)
    end
  end
end
