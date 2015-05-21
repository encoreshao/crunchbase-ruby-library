# encoding: utf-8

module Crunchbase::Model
  class Product < Crunchbase::Model::Entity
    
    RESOURCE_LIST = 'products'

    attr_reader :permalink, :api_path, :web_path, :name, :also_known_as, 
                :lifecycle_stage, :short_description, :description, 
                :launched_on, :launched_on_trust_code, :closed_on, :closed_on_trust_code, 
                :homepage_url, :created_at, :updated_at

    # attr_reader :owner, :categories, :primary_image, :competitors, :customers, :websites, :images, :video, :news

    # attr_reader :owner_total_items, :categories_items, :primary_image_total_items, 
    #             :competitors_total_items, :customers_total_items, :websites_total_items
    #             :images_total_items, :video_total_items, :new_total_items


    def property_keys
      %w[
        permalink api_path web_path name also_known_as 
        lifecycle_stage short_description description 
        launched_on launched_on_trust_code closed_on closed_on_trust_code 
        homepage_url created_at updated_at
      ]
    end

    def date_keys
      %w[launched_on closed_on]
    end

  end
end