# encoding utf-8

module Crunchbase::Model
  class Fund < Crunchbase::Model::Entity

    RESOURCE_LIST = 'funds'

    attr_reader :api_path, :web_path, :name, :announced_on, :announced_on_trust_code, :money_raised, :money_raised_currency_code, :money_raised_usd, :created_at, :updated_at

    # attr_reader :venture_firm, :investor, :images, :videos, :news

    # attr_reader :venture_firm_total_items, :investor_total_items, :images_total_items, :videos_total_items, :news_total_items

    def property_keys
      %w[
        api_path web_path name announced_on announced_on_trust_code
        money_raised money_raised_currency_code money_raised_usd created_at updated_at
      ]
    end

    def date_keys
      %w[ announced_on ]
    end

  end
end
