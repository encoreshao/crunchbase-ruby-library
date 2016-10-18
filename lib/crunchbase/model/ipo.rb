# encoding: utf-8

module Crunchbase::Model
  class Ipo < Crunchbase::Model::Entity

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

      unless (relationships = json['relationships']).nil?
        set_relationships_object(Crunchbase::Model::Organization, 'funded_company', relationships['funded_company'])
        set_relationships_object(Crunchbase::Model::New, 'news', relationships['news'])
        set_relationships_object(Crunchbase::Model::Video, 'videos', relationships['videos'])
      end
    end


    def property_keys
      %w[
        api_path web_path went_public_on went_public_on_trust_code
        stock_exchange_symbol stock_symbol
        shares_sold opening_share_price
        opening_share_price_currency_code opening_share_price_usd opening_valuation
        opening_valuation_currency_code opening_valuation_usd
        money_raised money_raised_currency_code money_raised_usd
        created_at updated_at
      ]
    end

    def date_keys
      %w[went_public_on]
    end

  end
end
