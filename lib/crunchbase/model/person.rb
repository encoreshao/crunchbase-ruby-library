# encoding: utf-8

module Crunchbase::Model
  class Person < Crunchbase::Model::Entity
    
    RESOURCE_NAME = 'person'
    
    attr_reader :permalink, :api_path, :web_path, :first_name, :last_name, :also_known_as, :bio, 
                :role_investor, :born_on, :born_on_trust_code, :is_deceased, :died_on, :died_on_trust_code, 
                :created_at, :updated_at

    # attr_reader :primary_affiliation, :primary_location, :primary_image, :websites, :degrees, :jobs, 
    #             :advisory_roles, :founded_companies, :investments, :memberships, :images, :videos, :news

    # attr_reader :primary_affiliation_total_items, :primary_location_total_items, 
    #             :primary_image_total_items,  :websites_total_items, :degrees_total_items, :jobs_total_items,
    #             :advisory_roles_total_items, :founded_companies_total_items, 
    #             :investments_total_items, :memberships_total_items, :images_total_items, :videos_total_items, 
    #             :news_total_items
                

    def initialize(json)
      super
      
    end

    def property_keys
      %w[
          permalink api_path web_path first_name last_name also_known_as bio 
          role_investor born_on born_on_trust_code is_deceased died_on died_on_trust_code 
          created_at updated_at
      ]
    end

    def date_keys
      %w[ born_on died_on ]
    end


  end
end