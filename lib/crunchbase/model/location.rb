# encoding: utf-8

module Crunchbase::Model
  class Location < Crunchbase::Model::Entity

    RESOURCE_LIST = 'locations'

    attr_reader :web_path, :name, :location_type, :parent_location_uuid,
                :city, :city_web_path,
                :region, :region_code2, :region_web_path,
                :country, :country_code2, :country_code3, :country_web_path,
                :continent, :continent_web_path,
                :created_at, :updated_at

    attr_reader :parent_locations

    attr_reader :parent_locations_total_items

    def initialize(json)
      super

      unless (relationships = json['relationships']).nil?
        set_relationships_object(Crunchbase::Model::ParentLocation, 'parent_locations', relationships['parent_locations'])
      end
    end

    def property_keys
      %w[
        web_path name location_type parent_location_uuid created_at updated_at
        city city_web_path region region_web_path region_code2
        country country_web_path country_code2 country_code3
        continent continent_web_path
      ]
    end

  end
end
