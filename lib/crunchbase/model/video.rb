# encoding: utf-8

module Crunchbase::Model
  class Video < Crunchbase::Model::Entity

    RESOURCE_LIST = 'videos'

    attr_reader :title, :service_name, :url, :created_at, :updated_at

    def property_keys
      %w[
        title service_name url created_at updated_at 
      ]
    end
    
  end
end