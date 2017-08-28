# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class Person < Crunchbase::Model::Entity
    RESOURCE_LIST = RESOURCE_NAME = 'people'

    attr_reader :permalink, :api_path, :web_path, :first_name, :last_name, :gender, :also_known_as, :bio, :profile_image_url,
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
      super

      unless (relationships = json['relationships']).nil?
        set_relationships_object(Crunchbase::Model::PrimaryAffiliation, 'primary_affiliation', relationships['primary_affiliation'])
        set_relationships_object(Crunchbase::Model::PrimaryLocation, 'primary_location', relationships['primary_location'])
        set_relationships_object(Crunchbase::Model::PrimaryImage, 'primary_image', relationships['primary_image'])
        set_relationships_object(Crunchbase::Model::Website, 'websites', relationships['websites'])
        set_relationships_object(Crunchbase::Model::Degree, 'degrees', relationships['degrees'])
        set_relationships_object(Crunchbase::Model::Job, 'jobs', relationships['jobs'])
        set_relationships_object(Crunchbase::Model::AdvisoryRole, 'advisory_roles', relationships['advisor_at'])
        set_relationships_object(Crunchbase::Model::FoundedCompany, 'founded_companies', relationships['founded_companies'])
        set_relationships_object(Crunchbase::Model::Investment, 'investments', relationships['investments'])
        set_relationships_object(Crunchbase::Model::Membership, 'memberships', relationships['memberships'])
        set_relationships_object(Crunchbase::Model::Image, 'images', relationships['images'])
        set_relationships_object(Crunchbase::Model::Video, 'videos', relationships['videos'])
        set_relationships_object(Crunchbase::Model::New, 'news', relationships['news'])
      end
    end

    def property_keys
      %w(
        permalink api_path web_path first_name last_name gender also_known_as bio profile_image_url
        role_investor born_on born_on_trust_code is_deceased died_on died_on_trust_code
        created_at updated_at
      )
    end

    def date_keys
      %w(born_on died_on)
    end
  end
end
