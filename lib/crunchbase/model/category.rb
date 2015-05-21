# encoding: utf-8

module Crunchbase::Model
  class Category < Crunchbase::Model::Entity
    
    RESOURCE_LIST = 'categories'

    attr_reader :web_path, :name, :organizations_in_category, :products_in_category, :created_at, :updated_at

  end
end