# encoding: utf-8

module Crunchbase::Model
  class Image < Crunchbase::Model::Entity

    RESOURCE_LIST = 'images'

    attr_reader :asset_path, :content_type, :height, :width, :filesize, :created_at, :updated_at
    
    def property_keys
      %w[
        asset_path content_type height width filesize created_at updated_at
      ]
    end
    
  end
end