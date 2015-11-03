# encoding: utf-8

module Crunchbase::Model
  class Website < Crunchbase::Model::Entity

    RESOURCE_LIST = 'websites'

    attr_reader :url, :created_at, :updated_at

    # TODO: 2015-11-03
    attr_reader :website # already removed
    attr_reader :website_type, :website_name # newly added

    def property_keys
      %w[
        website
        url created_at updated_at
        website_type website_name
      ]
    end

  end
end
