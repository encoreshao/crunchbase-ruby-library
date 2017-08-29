# frozen_string_literal: true
# encoding utf-8

module Crunchbase::Model
  class Fund < Entity
    RESOURCE_LIST = 'funds'

    attr_reader :api_path, :web_path, :name, :announced_on, :announced_on_trust_code,
                :money_raised, :money_raised_currency_code, :money_raised_usd,
                :created_at, :updated_at

    def property_keys
      %w(
        api_path web_path name announced_on announced_on_trust_code
        money_raised money_raised_currency_code money_raised_usd created_at updated_at
      )
    end

    def date_keys
      %w(announced_on)
    end
  end
end
