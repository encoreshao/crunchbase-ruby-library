# encoding: utf-8

module Crunchbase::Model
  class Website < Crunchbase::Model::Entity

    RESOURCE_LIST = 'websites'

    attr_reader :website, :url, :created_at, :updated_at

    def property_keys
      %w[
        website url created_at updated_at 
      ]
    end

  end
end