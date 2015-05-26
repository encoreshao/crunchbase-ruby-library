# encoding: utf-8

module Crunchbase::Model
  class Product < Crunchbase::Model::Entity
    
    RESOURCE_LIST = RESOURCE_NAME = 'products'

    attr_reader :permalink, :api_path, :web_path, :name, :also_known_as, 
                :lifecycle_stage, :short_description, :description, 
                :launched_on, :launched_on_trust_code, :closed_on, :closed_on_trust_code, 
                :homepage_url, :created_at, :updated_at

    attr_reader :websites, :primary_image, :images, :images_total_items, :categories, :video, :news

    attr_reader :websites_total_items, :primary_image_total_items, :categories_items, :video_total_items, :new_total_items

    # attr_reader :owner, :competitors, :customers

    # attr_reader :owner_total_items, :competitors_total_items, :customers_total_items

    def initialize(json)
      super

      unless (relationships = json['relationships']).nil?
        set_relationships_object(Crunchbase::Model::Category, 'categories', relationships['categories'])
        set_relationships_object(Crunchbase::Model::PrimaryImage, 'primary_image', relationships['primary_image'])
        set_relationships_object(Crunchbase::Model::Image, 'images', relationships['images'])
        set_relationships_object(Crunchbase::Model::Video, 'video', relationships['video'])
        set_relationships_object(Crunchbase::Model::New, 'news', relationships['news'])
      end
    end

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