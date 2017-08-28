# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class Organization < Crunchbase::Model::Entity
    RESOURCE_LIST = RESOURCE_NAME = 'organizations'

    attr_reader :permalink, :api_path, :web_path, :name, :also_known_as, :short_description, :description,
                :profile_image_url, :primary_role, :role_company, :role_investor, :role_group, :role_school,
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

      relationships = json['relationships']
      return if relationships.nil?

      setup_relationships!(relationships)
    end

    def setup_relationships!(relationships)
      set_relationships_object(PrimaryImage, 'primary_image', relationships['primary_image'])
      set_relationships_object(Founder, 'founders', relationships['founders'])
      set_relationships_object(CurrentTeam, 'current_team', relationships['current_team'])
      set_relationships_object(PastTeam, 'past_team', relationships['past_team'])
      set_relationships_object(BoardMembersAndAdvisor, 'board_members_and_advisors', relationships['board_members_and_advisors'])
      set_relationships_object(Investor, 'investors', relationships['investors'])
      set_relationships_object(OwnedBy, 'owned_by', relationships['owned_by'])
      set_relationships_object(SubOrganization, 'sub_organizations', relationships['sub_organizations'])
      set_relationships_object(Headquarter, 'headquarters', relationships['headquarters'])
      set_relationships_object(Office, 'offices', relationships['offices'])
      set_relationships_object(Product, 'products', relationships['products'])
      set_relationships_object(Category, 'categories', relationships['categories'])
      set_relationships_object(Customer, 'customers', relationships['customers'])
      set_relationships_object(Competitor, 'competitors', relationships['competitors'])
      set_relationships_object(Membership, 'memberships', relationships['memberships'])
      set_relationships_object(FundingRound, 'funding_rounds', relationships['funding_rounds'])
      set_relationships_object(Investment, 'investments', relationships['investments'])
      set_relationships_object(Acquisition, 'acquisitions', relationships['acquisitions'])
      set_relationships_object(AcquiredBy, 'acquired_by', relationships['acquired_by'])
      set_relationships_object(Ipo, 'ipo', relationships['ipo'])
      set_relationships_object(Fund, 'funds', relationships['funds'])
      set_relationships_object(Website, 'websites', relationships['websites'])
      set_relationships_object(Image, 'images', relationships['images'])
      set_relationships_object(Video, 'videos', relationships['videos'])
      set_relationships_object(New, 'news', relationships['news'])
    end

    def property_keys
      %w(
        permalink api_path web_path name also_known_as short_description description
        profile_image_url primary_role role_company role_investor role_group role_school
        founded_on founded_on_trust_code is_closed closed_on closed_on_trust_code
        num_employees_min num_employees_max total_funding_usd
        stock_exchange stock_symbol
        number_of_investments homepage_url
        created_at updated_at
      )
    end

    def date_keys
      %w(founded_on closed_on)
    end
  end
end
