# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class FundingRound < Entity
    RESOURCE_LIST = 'funding_rounds'
    RESOURCE_NAME = 'funding-rounds'

    attr_reader :permalink, :api_path, :web_path, :funding_type, :series, :series_qualifier,
                :announced_on, :announced_on_trust_code, :closed_on, :closed_on_trust_code,
                :money_raised, :money_raised_currency_code, :money_raised_usd,
                :target_money_raised, :target_money_raised_currency_code, :target_money_raised_usd,
                :created_at, :updated_at

    attr_reader :investments, :funded_organization, :images, :videos, :news

    attr_reader :investments_total_items, :funded_organization_total_items, :images_total_items,
                :videos_total_items, :news_total_items

    def initialize(json)
      super

      relationships = json['relationships']
      return if relationships.nil?

      # set_relationships_object(Investment, 'investments', relationships['investments'])

      return if relationships['funded_organization'].nil?

      if relationships['funded_organization']['item'].nil?
        # Get organization's  (investments - funding - organization)
        instance_relationships_object(Organization, 'funded_organization', relationships['funded_organization'])
      else
        # Get funding-rounds (funded_organization - item)

        set_relationships_object(Organization, 'funded_organization', relationships['funded_organization'])
      end
    end

    def relationship_lists
      {
        'images' => Image,
        'videos' => Video,
        'news' => New
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
