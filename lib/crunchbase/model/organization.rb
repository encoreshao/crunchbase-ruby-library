# encoding: utf-8

module Crunchbase::Model
  class Organization < Crunchbase::Model::Entity
    
    RESOURCE_LIST = RESOURCE_NAME = 'organizations'

    attr_reader :permalink, :api_path, :web_path, :name, :also_known_as, :short_description, :description, 
                :primary_role, :role_company, :role_investor, :role_group, :role_school, 
                :founded_on, :founded_on_trust_code, :is_closed, :closed_on, :closed_on_trust_code, 
                :num_employees_min, :num_employees_max, 
                :total_funding_usd, 
                :stock_exchange, :stock_symbol, 
                :number_of_investments, :homepage_url, 
                :created_at, :updated_at

    attr_reader :primary_image, :founders, :current_team, :past_team, :board_members_and_advisors, 
                :investors, :owned_by, :sub_organizations, :headquarters, :offices, :products, 
                :categories, :customers, :competitors, :members, :memberships, :funding_rounds, :investments, 
                :acquisitions, :acquired_by, :ipo, :funds, :websites, :images, :videos, :news

    attr_reader :primary_image_total_items, :founders_total_items, :current_team_total_items, 
                :past_team_total_items, :board_members_and_advisors_total_items, :investors_total_items, 
                :owned_by_total_items, :sub_organizations_total_items, :headquarters_total_items, 
                :offices_total_items, :products_total_items, :categories_total_items, 
                :customers_total_items, :competitors_total_items, :members_total_items, 
                :memberships_total_items, :funding_rounds_total_items, :investments_total_items, 
                :acquisitions_total_items, :acquired_by_total_items, 
                :ipo_total_items, :funds_total_items, :websites_total_items, :images_total_items,
                :videos_total_items, :news_total_items

    def initialize(json)
      super

      unless (relationships = json['relationships']).nil?

        set_relationships_object(Crunchbase::Model::PrimaryImage, 'primary_image', relationships['primary_image'])
        set_relationships_object(Crunchbase::Model::Founder, 'founders', relationships['founders'])
        set_relationships_object(Crunchbase::Model::CurrentTeam, 'current_team', relationships['current_team'])
        set_relationships_object(Crunchbase::Model::Investor, 'investors', relationships['investors'])
        set_relationships_object(Crunchbase::Model::OwnedBy, 'owned_by', relationships['owned_by'])
        set_relationships_object(Crunchbase::Model::SubOrganization, 'sub_organizations', relationships['sub_organizations'])
        set_relationships_object(Crunchbase::Model::Headquarter, 'headquarters', relationships['headquarters'])
        set_relationships_object(Crunchbase::Model::Office, 'offices', relationships['offices'])
        set_relationships_object(Crunchbase::Model::Product, 'products', relationships['products'])
        set_relationships_object(Crunchbase::Model::Category, 'categories', relationships['categories'])
        set_relationships_object(Crunchbase::Model::Customer, 'customers', relationships['customers'])
        set_relationships_object(Crunchbase::Model::Competitor, 'competitors', relationships['competitors'])
        # set_relationships_object(PrimaryImage, 'members', relationships['members'])
        set_relationships_object(Crunchbase::Model::Membership, 'memberships', relationships['memberships'])
        set_relationships_object(Crunchbase::Model::FundingRound, 'funding_rounds', relationships['funding_rounds'])
        set_relationships_object(Crunchbase::Model::Investment, 'investments', relationships['investments'])
        set_relationships_object(Crunchbase::Model::Acquisition, 'acquisitions', relationships['acquisitions'])
        set_relationships_object(Crunchbase::Model::AcquiredBy, 'acquired_by', relationships['acquired_by'])
        set_relationships_object(Crunchbase::Model::Ipo, 'ipo', relationships['ipo'])
        set_relationships_object(Crunchbase::Model::Fund, 'funds', relationships['funds'])
        set_relationships_object(Crunchbase::Model::Website, 'websites', relationships['websites'])
        set_relationships_object(Crunchbase::Model::Image, 'images', relationships['images'])
        set_relationships_object(Crunchbase::Model::Video, 'videos', relationships['videos'])
        set_relationships_object(Crunchbase::Model::New, 'news', relationships['news'])
      end
    end

    def property_keys
      %w[
        permalink api_path web_path name also_known_as short_description description 
        primary_role role_company role_investor role_group role_school 
        founded_on founded_on_trust_code is_closed closed_on closed_on_trust_code 
        num_employees_min num_employees_max 
        total_funding_usd 
        stock_exchange stock_symbol 
        number_of_investments homepage_url 
        created_at updated_at
      ]
    end

    def date_keys
      %w[founded_on closed_on]
    end

    def self.organization_lists(permalink, options={})
      return []
    end

  end
end