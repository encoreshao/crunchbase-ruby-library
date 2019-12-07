# frozen_string_literal: true

module Crunchbase
  module Model
    class Person < Entity
      RESOURCE_LIST = RESOURCE_NAME = 'people'

      attr_reader :permalink, :permalink_aliases, :api_path, :api_url, :web_path, :rank,
                  :first_name, :last_name, :gender, :also_known_as, :bio, :profile_image_url,
                  :role_investor, :born_on, :born_on_trust_code, :is_deceased, :died_on, :died_on_trust_code,
                  :created_at, :updated_at

      attr_reader :primary_affiliation, :primary_location, :primary_image, :websites, :degrees, :jobs,
                  :advisory_roles, :founded_companies, :investments, :memberships, :images, :videos, :news

      attr_reader :primary_affiliation_total_items, :primary_location_total_items,
                  :primary_image_total_items,  :websites_total_items, :degrees_total_items, :jobs_total_items,
                  :advisory_roles_total_items, :founded_companies_total_items,
                  :investments_total_items, :memberships_total_items, :images_total_items, :videos_total_items,
                  :news_total_items

      def initialize(json)
        super(json)
      end

      def relationship_lists
        {
          'primary_affiliation' => PrimaryAffiliation,
          'primary_location' => PrimaryLocation,
          'primary_image' => PrimaryImage,
          'websites' => Website,
          'degrees' => Degree,
          'jobs' => Job,
          'advisory_roles' => AdvisoryRole,
          'founded_companies' => FoundedCompany,
          'investments' => Investment,
          'memberships' => Membership,
          'images' => Image,
          'videos' => Video,
          'news' => New
        }
      end

      def property_keys
        %w[
          permalink permalink_aliases api_path api_url web_path rank
          first_name last_name gender also_known_as bio profile_image_url
          role_investor born_on born_on_trust_code is_deceased died_on died_on_trust_code
          created_at updated_at
        ]
      end

      def date_keys
        %w[born_on died_on]
      end

      # custom name from first name and last name
      def name
        [first_name, last_name].compact.join(' ')
      end
    end
  end
end
