# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class Website < Entity
    RESOURCE_LIST = 'websites'

    attr_reader :url, :created_at, :updated_at
    attr_reader :website_type, :website_name

    def property_keys
      %w(
        url
        website_type website_name
        created_at updated_at
      )
    end
  end
end
