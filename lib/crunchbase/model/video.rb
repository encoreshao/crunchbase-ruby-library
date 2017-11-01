# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class Video < Entity
    RESOURCE_LIST = 'videos'

    attr_reader :title, :service_name, :url, :created_at, :updated_at

    def property_keys
      %w(
        title service_name url created_at updated_at
      )
    end
  end
end
