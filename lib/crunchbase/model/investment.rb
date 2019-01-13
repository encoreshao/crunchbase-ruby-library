# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class Investment < Entity
    RESOURCE_LIST = 'investments'.freeze

    attr_reader :money_invested, :money_invested_currency_code, :money_invested_usd, :is_lead_investor,
                :announced_on, :announced_on_trust_code, :created_at, :updated_at

    attr_reader :investors, :partners, :funding_round
    attr_reader :investors_total_items, :partners_total_items, :funding_round_total_items

    def initialize(json)
      super(json)
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

    def relationship_lists
      {
        'funding_round' => FundingRound,
        'investors' => Organization,
        'partners' => Person
      }
    end
  end
end
