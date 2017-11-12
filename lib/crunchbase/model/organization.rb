# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class Organization < Entity
    RESOURCE_LIST = RESOURCE_NAME = 'organizations'

    attr_reader :permalink, :api_path, :web_path, :name, :also_known_as, :short_description, :description,
                :profile_image_url, :primary_role, :role_company, :role_investor, :role_group, :role_school,
                :founded_on, :founded_on_trust_code, :is_closed, :closed_on, :closed_on_trust_code,
                :num_employees_min, :num_employees_max,
                :total_funding_usd,
                :stock_exchange, :stock_symbol,
                :number_of_investments, :homepage_url,
                :created_at, :updated_at

    attr_reader :primary_image, :founders, :featured_team, :current_team, :past_team, :board_members_and_advisors,
                :investors, :owned_by, :sub_organizations, :headquarters, :offices, :products,
                :categories, :customers, :competitors, :members, :memberships, :funding_rounds, :investments,
                :acquisitions, :acquired_by, :ipo, :funds, :websites, :images, :videos, :news

    attr_reader :primary_image_total_items, :founders_total_items, :featured_team_total_items, :current_team_total_items,
                :past_team_total_items, :board_members_and_advisors_total_items, :investors_total_items,
                :owned_by_total_items, :sub_organizations_total_items, :headquarters_total_items,
                :offices_total_items, :products_total_items, :categories_total_items,
                :customers_total_items, :competitors_total_items, :members_total_items,
                :memberships_total_items, :funding_rounds_total_items, :investments_total_items,
                :acquisitions_total_items, :acquired_by_total_items,
                :ipo_total_items, :funds_total_items, :websites_total_items, :images_total_items,
                :videos_total_items, :news_total_items

    def initialize(json)
      super(json)
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

    def relationship_lists
      {
        'primary_image' => PrimaryImage,
        'founders' => Founder,
        'featured_team' => FeaturedTeam,
        'current_team' => CurrentTeam,
        'past_team' => PastTeam,
        'board_members_and_advisors' => BoardMembersAndAdvisor,
        'investors' => Investor,
        'owned_by' => OwnedBy,
        'sub_organizations' => SubOrganization,
        'headquarters' => Headquarter,
        'offices' => Office,
        'products' => Product,
        'categories' => Category,
        'customers' => Customer,
        'competitors' => Competitor,
        'memberships' => Membership,
        'funding_rounds' => FundingRound,
        'investments' => Investment,
        'acquisitions' => Acquisition,
        'acquired_by' => AcquiredBy,
        'ipo' => Ipo,
        'funds' => Fund,
        'websites' => Website,
        'images' => Image,
        'videos' => Video,
        'news' => New
      }
    end

    def date_keys
      %w(founded_on closed_on)
    end
  end
end
