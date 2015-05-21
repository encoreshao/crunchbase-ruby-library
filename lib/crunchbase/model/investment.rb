# encoding: utf-8

module Crunchbase::Model
  class Investment < Crunchbase::Model::Entity
    
    RESOURCE_LIST = 'investments'

    attr_reader :money_invested, :money_invested_currency_code, :money_invested_usd, :created_at, :updated_at

    attr_reader :funding_round, :invested_in

    attr_reader :funding_round_total_items, :invested_in_total_items

    def initialize(json)
      super

      relationships  = json['relationships']

      set_relationships_object(Crunchbase::Model::FundingRound, 'funding_round', relationships['funding_round'])
    end

    def property_keys
      %w[
        money_invested money_invested_currency_code money_invested_usd created_at updated_at
      ]
    end


  end
end