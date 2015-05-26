# encoding: utf-8

module Crunchbase::Model
  class Investment < Crunchbase::Model::Entity
    
    RESOURCE_LIST = 'investments'

    attr_reader :money_invested, :money_invested_currency_code, :money_invested_usd, :created_at, :updated_at

    attr_reader :funding_round, :invested_in

    def initialize(json)
      super

      unless (relationships = json['relationships']).nil?
        instance_relationships_object(Crunchbase::Model::FundingRound, 'funding_round', relationships['funding_round'])
      end
    end

    def property_keys
      %w[
        money_invested money_invested_currency_code money_invested_usd created_at updated_at
      ]
    end

  end
end