# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class Ipo < Entity
    RESOURCE_LIST = RESOURCE_NAME = 'ipos'

    attr_reader :api_path, :web_path, :went_public_on, :went_public_on_trust_code,
                :stock_exchange_symbol, :stock_symbol,
                :shares_sold, :opening_share_price,
                :opening_share_price_currency_code, :opening_share_price_usd, :opening_valuation,
                :opening_valuation_currency_code, :opening_valuation_usd,
                :money_raised, :money_raised_currency_code, :money_raised_usd,
                :created_at, :updated_at

    attr_reader :funded_company, :stock_exchange, :images, :videos, :news

    def initialize(json)
      super
    end

    def relationship_lists
      {
        'funded_company' => Organization,
        'news' => New,
        'videos' => Video
      }
    end

    def property_keys
      %w(
        api_path web_path went_public_on went_public_on_trust_code
        stock_exchange_symbol stock_symbol
        shares_sold opening_share_price
        opening_share_price_currency_code opening_share_price_usd opening_valuation
        opening_valuation_currency_code opening_valuation_usd
        money_raised money_raised_currency_code money_raised_usd
        created_at updated_at
      )
    end

    def date_keys
      %w(went_public_on)
    end
  end
end
