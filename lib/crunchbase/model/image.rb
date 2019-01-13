# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class Image < Entity
    RESOURCE_LIST = 'images'.freeze

    attr_reader :asset_path, :asset_url, :content_type, :height, :width, :filesize, :created_at, :updated_at

    def property_keys
      %w(
        asset_url asset_path content_type height width filesize created_at updated_at
      )
    end
  end
end
