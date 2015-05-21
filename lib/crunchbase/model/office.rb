# encoding: utf-8

module Crunchbase::Model
  class Office < Crunchbase::Model::Entity

    RESOURCE_LIST = 'offices'
    attr_reader :type_name, :name, :street_1, :street_2, :postal_code, :city, :city_path,
                :region, :region_path, :country, :country_path, :latitude, :longitude,
                :created_at, :updated_at
                
    def initialize(json)
    end

  end
end