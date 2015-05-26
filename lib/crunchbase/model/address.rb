# encoding: utf-8

module Crunchbase::Model
  class Address < Crunchbase::Model::Entity
    
    RESOURCE_LIST = 'addresses'

    attr_reader :name, :street_1, :street_2, :city, :city_web_path, :region, :region_web_path, 
                :country, :country_web_path, :latitude, :longitude, :created_at, :updated_at


    def property_keys
      %w[
        name street_1 street_2 city city_web_path region region_web_path 
        country country_web_path latitude longitude created_at updated_at
      ]
    end

  end
end