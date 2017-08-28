# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class OrganizationSummary < Crunchbase::Model::Entity
    attr_reader :permalink, :api_path, :web_path, :name, :primary_role, :short_description, :profile_image_url,
                :domain, :homepage_url, :facebook_url, :twitter_url, :linkedin_url, :city_name, :region_name, :country_code,
                :created_at, :updated_at

    def property_keys
      %w(
        permalink api_path web_path name primary_role short_description profile_image_url
        domain homepage_url facebook_url twitter_url linkedin_url city_name region_name country_code
        created_at updated_at
      )
    end
  end
end
