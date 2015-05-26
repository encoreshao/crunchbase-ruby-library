# encoding: utf-8

module Crunchbase::Model
  class PersonSummary < Crunchbase::Model::Entity
    
    attr_reader :permalink, :api_path, :web_path, :first_name, :last_name, :title, 
                :organization_permalink, :organization_api_path, :organization_web_path, :organization_name, 
                :profile_image_url, :homepage_url, :facebook_url, :twitter_url, :linkedin_url, 
                :city_name, :region_name, :country_code, 
                :created_at, :updated_at

    def property_keys
      %w[
        permalink api_path web_path first_name last_name title 
        organization_permalink organization_api_path organization_web_path organization_name 
        profile_image_url homepage_url facebook_url twitter_url linkedin_url 
        city_name region_name country_code 
        created_at updated_at
      ]
    end

  end
end