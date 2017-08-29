# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class Category < Entity
    RESOURCE_LIST = RESOURCE_NAME = 'categories'

    attr_reader :web_path, :name, :organizations_in_category, :products_in_category, :created_at, :updated_at

    def property_keys
      %w(
        web_path name organizations_in_category products_in_category created_at updated_at
      )
    end
  end
end
