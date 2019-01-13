# encoding: utf-8
# frozen_string_literal: true

module Crunchbase::Model
  class FoundedCompany < Organization
    RESOURCE_LIST = 'founded_companies'.freeze

    #
    # 2015-11-03 Removed
    #
    # attr_reader :type, :name, :path, :created_at, :updated_at

    # def initialize(json)
    #   property_keys.each { |v|
    #     instance_variable_set("@#{v}", json[v] || nil)
    #   }

    #   %w[created_at updated_at].each { |v|
    #     instance_variable_set("@#{v}", Time.at(json[v]))
    #   }
    # end

    # def property_keys
    #   %w[
    #     type name path created_at updated_at
    #   ]
    # end
  end
end
