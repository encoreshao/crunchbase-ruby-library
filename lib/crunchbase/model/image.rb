# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class Image < Crunchbase::Model::Entity
    RESOURCE_LIST = 'images'

    attr_reader :asset_path, :asset_url, :content_type, :height, :width, :filesize, :created_at, :updated_at

    def property_keys
      %w(
        asset_url asset_path content_type height width filesize created_at updated_at
      )
    end
  end
end
