# encoding: utf-8

module Crunchbase::Model
  class OwnedBy < Crunchbase::Model::Entity

    attr_reader :name, :api_path, :web_path, :created_at, :updated_at

    def initialize(json)
      super
    end

    def property_keys
      %w[
        name api_path web_path created_at updated_at
      ]
    end

  end
end
