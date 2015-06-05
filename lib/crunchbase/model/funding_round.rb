# encoding: utf-8

module Crunchbase::Model
  class FundingRound < Crunchbase::Model::Entity
    
    RESOURCE_LIST = 'funding_rounds'
    RESOURCE_NAME = 'funding-rounds'

    attr_reader :api_path, :web_path, :funding_type, :series, :series_qualifier, 
                :announced_on, :announced_on_trust_code, :closed_on, :closed_on_trust_code, 
                :money_raised, :money_raised_currency_code, :money_raised_usd,
                :target_money_raised, :target_money_raised_currency_code, :target_money_raised_usd, 
                :created_at, :updated_at

    attr_reader :investments, :funded_organization, :images, :videos, :news

    attr_reader :investments_total_items, :funded_organization_total_items, :images_total_items, 
                :videos_total_items, :news_total_items

    def initialize(json)
      super

      unless (relationships = json['relationships']).nil?
        set_relationships_object(Crunchbase::Model::Investment, 'investments', relationships['investments'])

        unless relationships['funded_organization'].nil?
          if relationships['funded_organization']['item'].nil?

            # Get organization's  (investments - funding - organization)
            instance_relationships_object(Crunchbase::Model::Organization, 'funded_organization', relationships['funded_organization'])
          else
            # Get funding-rounds (funded_organization - item)

            set_relationships_object(Crunchbase::Model::Organization, 'funded_organization', relationships['funded_organization'])
          end
        end

        set_relationships_object(Crunchbase::Model::Image, 'images', relationships['images'])
        set_relationships_object(Crunchbase::Model::Video, 'videos', relationships['videos'])
        set_relationships_object(Crunchbase::Model::New, 'news', relationships['news'])
      end

    end
    
    def property_keys
      %w[
        api_path web_path funding_type series series_qualifier 
        announced_on announced_on_trust_code closed_on closed_on_trust_code 
        money_raised money_raised_currency_code money_raised_usd 
        target_money_raised target_money_raised_currency_code target_money_raised_usd 
        created_at updated_at
      ]
    end

    def date_keys
      %w[ announced_on closed_on ]
    end

  end
end
